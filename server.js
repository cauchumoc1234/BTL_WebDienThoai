const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const port = 3000
const login_router = require('./public/js/routes/login.router')
const product_controller = require('./controller/product.controller')
var connection = require('./db');
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
  //kết nối sql
connection.connect((err)=>{
    //nếu có nỗi thì in ra
    if(err) throw err.stack
    //nếu thành công
    console.log("Success connected");
})
app.get('/',(req,res)=>{
  res.redirect('/home')
})
app.use('/login',login_router)
app.get('/home',(req,res)=>{
  var x= connection.query("SELECT * FROM `products` ORDER BY `quantityInStock` ASC LIMIT 5",function(err,result){
    if(err) throw err
    res.render('index',{
      hots: result
    })
  })
    
})
app.get('/search',product_controller.search)