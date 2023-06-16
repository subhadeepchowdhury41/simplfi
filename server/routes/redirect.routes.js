module.exports = (app) => {
    app.use((req, res, next) => {
        res.header(
            "Access-Control-Allow-Headers",
            "Content-Type", "Origin", "Accept"
        );
        next();
    });
    const controller = require('../controllers/redirect.controller');
    app.get('/redirect/:consentHandle/:custId', [], controller.updateConsent);
}