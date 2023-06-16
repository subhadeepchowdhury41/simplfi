const { db } = require("../config/firebase.config");

exports.updateConsent = async (req, res) => {
  var res = await fetch(
    `https://dhanaprayoga.fiu.finfactor.in/finsense/API/V1/ConsentStatus/${req.params.consentHandle}/${req.params.custId}`,
    {
      headers: {
        Authorization: req.headers.Authorization,
      },
      method: "GET",
    }
  ).then(async (res) => {
    if (res.body == null || res.status <= 400)
      var status = res.body.body.consentStatus;
    await db
      .collection("consents")
      .doc(req.params.consentHandle)
      .update({
        status: status,
      })
      .then(async (result) => {
        return res.status(200).send("All the best!");
      });
  });
};
