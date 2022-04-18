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

router.get("/getCountry/:id", (request,response)=>{
    db.query("select * from countries where id = ?", [request.params.id], (err, results)=>{
        if(err) throw err;
        response.send(results);
    })
});

router.get("/getAllCountryInfo/:id", (request,response)=>{
    db.query(`select countries.name, countries.capital, countries.flag,
    languages.name AS language
    from countries
    inner join languages on countries.language_id = language_id where countries.id=?`, [request.params.id], (err, results)=>{
        if(err) throw err;
        response.send(results);
    })
})

router.post("/addCountry", (request,response)=>{
    db.query("insert into countries(name,flag,language_id,capital, banner_img)values(?,?,?,?,?)", [request.body.name,request.body.flag,request.body.language_id,request.body.capital, request.body.banner_img], (err, results)=>{
        if(err) throw err;
        response.send("Country successfully added");
    })
});
module.exports = router;