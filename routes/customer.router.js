const express = require('express');
const customer_router = express.Router();
const customer_controller = require('../controller/customer.controller')
customer_router.get('/',function(req,res){
    res.render('customer/customer')
  })
customer_router.post('/login',customer_controller.postLogin)
customer_router.post('/create',customer_controller.create)
customer_router.get('/profile',customer_controller.showProfile)
customer_router.post('/profile/update',customer_controller.update)
module.exports = customer_router;