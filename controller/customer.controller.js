const connection = require('../db')
//Create new user
module.exports.create = function(req,res){
    var sql = "INSERT INTO `customers` (`customerID`, `username`, `password`, `customerName`, `phoneNumber`, `address`) VALUES (NULL, ?, ?, ?, ?, ?);"
    connection.query(sql,[req.body.username,req.body.password,req.body.fullname,req.body.phonenumbers,req.body.address],function(err,result){
        if(err) throw err.stack;
        res.redirect('back');
    })
}
//Login
module.exports.postLogin = function(req,res){
    var username = req.body.username;
    var password = req.body.password;
    connection.query("SELECT * FROM `customers` WHERE `username` = "+req.body.username,function(err,result){
            if(!result){
            res.render('customer/customer',{
                errors:[
                'User does not exists'
                ]
            })
            return;
            }
            if(result[0].password !== password){
            res.render('customer/customer',{
                errors:[
                'Wrong password'
                ]
            })
            return;
            }
            res.cookie('customerID',result[0].customerID)
            res.redirect('/home')
            
    })

  }
//Show user information
module.exports.showProfile = function(req,res){
    var sql = "SELECT * FROM `customers` WHERE `customerID` = "+req.cookies.customerID;
    connection.query(sql,function(err,result){
        if(result){
            res.render('customer/profile',{
                user: result[0]
            })
        }
    })
    
}
//Change user information
module.exports.update=function(req,res){
    var sql = "UPDATE `customers` SET `password` = ?, `customerName` = ?,`phoneNumber` = ?, `address` = ? WHERE `customers`.`username` = "+req.body.username
    connection.query(sql,[req.body.password,req.body.fullname,req.body.phonenumbers,req.body.address],function(err,result){
        if(err) throw err;
        var sql = "SELECT * FROM `customers` WHERE `customerID` = "+req.cookies.customerID;
    connection.query(sql,function(err,result){
        if(result){
            res.render('customer/profile',{
                user: result[0],
                alert: "Changed successfully"
            })
        }
    })
    })
}
module.exports.showCart = function(req,res){
    res.render('customer/cart')
}
module.exports.logout= function(req,res){
    res.clearCookie("customerID")
    res.redirect('/home')
}