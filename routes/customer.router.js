const express = require('express');
const customer_router = express.Router();
const customer_controller = require('../controller/customer.controller')
const customer_middleware = require('../middleware/customer.middleware')
customer_router.get('/',function(req,res){
    res.render('customer/customer')
  })
customer_router.post('/login',customer_controller.postLogin)
customer_router.post('/create',customer_controller.create)
customer_router.get('/profile',customer_controller.showProfile)
customer_router.post('/profile/update',customer_controller.update)
customer_router.get('/cart',customer_middleware.requireAuth,customer_controller.showCart)
customer_router.get('/logout',customer_controller.postLogout)
module.exports = customer_router;