const express = require('express')
const app = express()
const mysql = require('mysql')
const bodyParser = require('body-parser')
const port = 3000
const login_router = require('./routes/login.router')
app.listen(port,()=>console.log("Server is running at port",port))
app.use([
    bodyParser.json(),
    bodyParser.urlencoded({
      extended: true,
    })
  ])
app.use(express.static("public"));
app.set('view engine', 'pug');
app.set('views','./views');

var connection = mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'',
    database:'cellphoneshopdb',
    charset:'utf8_general_ci'
  })
  //kết nối sql
connection.connect((err)=>{
    //nếu có nỗi thì in ra
    if(err) throw err.stack
    //nếu thành công
    console.log("Success connected");
    var sql = "SELECT * FROM products";
    connection.query(sql,(err,res)=>{
        if(err) throw err.stack
        //console.log(res);
    })
})
app.use('/login',login_router)
app.get('/',(req,res)=>{
    res.render('index')
    console.log("succees");
})
