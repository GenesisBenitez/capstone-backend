const { response } = require('express');
const express = require('express');
const router = express.Router();
const db = require("../mysql/dbConfig");

router.get("/getAllUsers", (request,response)=>{
    db.query("select * from users", (err, results)=>{
        if(err) throw err;
        response.send(results);
    })
});

router.get("/getUser/:id", (request,response)=>{
    db.query("select * from users where id = ?", [request.params.id], (err, results)=>{
        if(err) throw err;
        response.send(results);
    })
});
router.get("/getUserCountry/:id", (request,response)=>{
    db.query(`select countries.name from 
    users
    inner join countries on users.country_id = countries.id
    where countries.id = ?`, [request.params.id], (err, results)=>{
        if(err) throw err;
        response.send(results);
    })
});
module.exports = router;