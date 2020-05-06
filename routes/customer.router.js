const express = require('express');
const customer_router = express.Router();
const customer_controller = require('../controller/customer.controller')
customer_router.get('/',function(req,res){
    res.render('customer/customer')
  })
customer_router.post('/login',customer_controller.login)
customer_router.post('/create',customer_controller.create)
module.exports = customer_router;