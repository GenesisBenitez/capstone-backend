const mysql = require('mysql');

const connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "password",
    database: "capstone"
});

connection.connect(function(err){
    if(err) throw err;
});

module.exports = connection;