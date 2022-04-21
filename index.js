const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const session = require('express-session');

//route imports//

const countryRoutes = require("./routes/countryRoutes");
const authRoutes = require("./routes/auth");
const userRoutes = require("./routes/userRoutes");
const languageRoutes = require("./routes/languageRoutes");
const bookRoutes = require("./routes/bookRoutes");
const authorRoutes = require("./routes/authorRoutes");
const bookCommentRoutes = require("./routes/bookCommentRoutes");

const app = express();
const port = 8080;

app.use(cors({
    origin: "http://localhost:3000",
    methods: ["POST", "PUT", "GET", "DELETE", "OPTIONS", "HEAD"],
    credentials: true
}));

app.use(session({
    secret: "secret",
    resave: "true",
    saveUninitialized: "true"
}));

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

app.use("/", authRoutes);
app.use("/countries", countryRoutes);
app.use("/users", userRoutes);
app.use("/languages", languageRoutes);
app.use("/books", bookRoutes);
app.use("/authors", authorRoutes);
app.use("/bookComments", bookCommentRoutes);

app.listen(port, ()=> {
    console.log(`Listening on port ${port}`)
})