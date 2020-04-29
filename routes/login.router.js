const express = require('express');
const login_router = express.Router();
login_router.get('/',function(req,res){
    res.render('login_form')
  })
module.exports = login_router;