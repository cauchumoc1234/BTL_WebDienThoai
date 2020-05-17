const connection = require('../db')
module.exports.requireAuth = function(req,res,next){
    if(!req.signedCookies.customerID){
        res.redirect('/customer')
        return;
      }
    var sql = "SELECT * FROM `customers` WHERE `customerID` ="+req.signedCookies.customerID;
    connection.query(sql,function(err,result){
        if(err) throw err;
        if(result){
            next();
        }
        else res.redirect('/customer')
    })
}