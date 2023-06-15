import express from "express";
import cors from "cors";

const app = express();

app.use(cors({
    origin: '*'
}));

app.listen(3000, () => {
    console.log('App is running');
});