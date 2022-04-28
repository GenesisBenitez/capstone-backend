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
router.get("/getUserInfo/:id", (request,response)=>{
    db.query(`select users.id, users.first_name, users.last_name, users.admin,
    users.avatar, users.bio, users.email, users.created_at, users.username,
    countries.name AS country_name, countries.flag,
    COUNT(books.id) as books_posted_count,
    COUNT(films.id) as films_posted_count,
    COUNT(history_topics.id) as history_posted_count
    from users
    inner join countries on users.country_id = countries.id
    left join books on users.id = books.user_id
    left join films on users.id = films.user_id
    left join history_topics on users.id = history_topics.user_id
    where users.id = ?`, [request.params.id], (err, results)=>{
        if(err) throw err
        response.send(results);
    })
});

router.put("/updateAvatar/:id", (request,response)=>{
    db.query(`update users set avatar = ? where id = ?`, [request.body.avatar, request.params.id], (err, results)=>{
        if(err) throw err;
        request.session.avatar = request.body.avatar;
        response.send("Avatar successfully updated");
    })
})

module.exports = router;