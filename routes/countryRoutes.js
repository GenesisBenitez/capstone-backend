const { response } = require('express');
const express = require('express');
const router = express.Router();
const db = require("../mysql/dbConfig");

router.get("/getAllCountries", (request,response)=>{
    db.query("select * from countries", (err, results)=>{
        if(err) throw err;
        response.send(results);
    })
});

module.exports = router;