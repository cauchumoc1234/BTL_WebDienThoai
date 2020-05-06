const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const port = 3000
const customer_router = require('./routes/customer.router')
const product_controller = require('./controller/product.controller')
const product_view = require('./routes/product_view.router')
var connection = require('./db');
var cookieParser = require('cookie-parser')
app.use(cookieParser())
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
app.use('/customer',customer_router)
app.use('/product',product_view);
app.get('/home',(req,res)=>{
  var x= connection.query("SELECT * FROM `products` ORDER BY `quantityInStock` ASC LIMIT 5",function(err,result){
    if(err) throw err
    res.render('index',{
      hots: result
    })
  })
})
app.get('/search',product_controller.search)
