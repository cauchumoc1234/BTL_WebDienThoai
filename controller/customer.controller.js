const connection = require('../db')
module.exports.login = function(req,res){
    res.send(req.body);
}
module.exports.create = function(req,res){
    var sql = "INSERT INTO `customers` (`customerID`, `username`, `password`, `customerName`, `phoneNumber`, `address`) VALUES (NULL, ?, ?, ?, ?, ?);"
    connection.query(sql,[req.body.username,req.body.password,req.body.fullname,req.body.phonenumbers,req.body.address],function(err,result){
        if(err) throw err.stack;
        res.redirect('back');
    })
}