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

module.exports = router;