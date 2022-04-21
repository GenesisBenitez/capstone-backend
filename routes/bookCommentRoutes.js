const { response } = require('express');
const express = require('express');
const router = express.Router();
const db = require("../mysql/dbConfig");

router.get("/getAllComments", (request,response)=>{
    db.query("select * from book_comments", (err, results)=>{
        if(err) throw err;
        response.send(results);
    })
});

router.get("/getBookComment/:id", (request,response)=>{
    db.query("select * from book_comments where id = ?", [request.params.id], (err, results)=>{
        if(err) throw err;
        response.send(results);
    })
});

router.get("/getAllCommentsByBookId/:id", (request,response)=>{
    db.query(`select book_comments.comment, book_comments.rating,
    users.id as userId, users.username, users.avatar
    from book_comments
    inner join users on book_comments.user_id = users.id
    where book_id = ?`, [request.params.id], (err, results)=>{
        if(err) throw err;
        response.send(results);
    })
});
router.post("/addBookComment", (request,response)=>{
    db.query("insert into book_comments(user_id,book_id,comment,rating)values(?,?,?,?)", [request.body.user_id,request.body.book_id,request.body.comment, request.body.rating], (err, results)=>{
        if(err) throw err;
        response.send("Book comment successfully added");
    })
});

module.exports = router;
