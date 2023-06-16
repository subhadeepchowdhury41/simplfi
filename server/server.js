const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors({
    origin: '*'
}));

require('./routes/redirect.routes')(app);

app.listen(3000, () => {
    console.log('App is running');
});