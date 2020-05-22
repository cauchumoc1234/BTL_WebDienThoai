require('dotenv').config()
const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const port = 3000
const customer_router = require('./routes/customer.router')
const product_controller = require('./controller/product.controller')
const product_view = require('./routes/product_view.router')
var connection = require('./db');
var cookieParser = require('cookie-parser')
var sessionMiddleware = require('./middleware/session.middleware')
//Khai báo sử dụng middleware cookieParse()
app.use(cookieParser(process.env.APP_SECRET))
app.set('port', (process.env.PORT || 3000));
app.get('/', function(request, response) {
  // response.redirect('https://aladin-tech.herokuapp.com/home');
  response.render('index')
}).listen(app.get('port'), function() {
  console.log('App is running, server is listening on port ', app.get('port'));
});
app.use([
    bodyParser.json(),
    bodyParser.urlencoded({
      extended: true,
    })
  ])
//Set địa chỉ file tĩnh
app.use(express.static("public"));
//Set đọc file pug
app.set('view engine', 'pug');
app.set('views','./views');
app.use(sessionMiddleware);
// app.get('/',(req,res)=>{
//   res.redirect('/home')
// })
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
