const connection = require('../db')
const shortid = require('shortid')
//Create new user
module.exports.create = function(req,res){
    var first_check = "SELECT * FROM `customers` WHERE `username` = ?"
    connection.query(first_check,[req.body.username],(err,result)=>{
        if(err) throw err;
        if(result.length > 0){
            res.render('customer/customer',{
                form_err:"Username was used"
            })
            return;
        }
        var sql = "INSERT INTO `customers` (`customerID`, `username`, `password`, `customerName`, `phoneNumber`, `address`) VALUES (NULL, ?, ?, ?, ?, ?);"
        connection.query(sql,[req.body.username,req.body.password,req.body.fullname,req.body.phonenumbers,req.body.address],function(err,result){
            if(err) throw err.stack;
            res.redirect('back');
        })
    })
    
    
}
//Login
module.exports.postLogin = function(req,res){
    var username = req.body.username;
    var password = req.body.password;
    connection.query("SELECT * FROM `customers` WHERE `username` = '"+req.body.username+"'",function(err,result){
            if(result.length == 0){
                //console.log(result);
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
            res.cookie('customerID',result[0].customerID,{signed: true})
            res.redirect('/home')
            
    })

  }
//Show user information
module.exports.showProfile = function(req,res){
    var sql = "SELECT * FROM `customers` WHERE `customerID` = "+req.signedCookies.customerID;
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
    var sql = "UPDATE `customers` SET `password` = ?, `customerName` = ?,`phoneNumber` = ?, `address` = ? WHERE `customers`.`username` = '"+req.body.username +"'";
    connection.query(sql,[req.body.password,req.body.fullname,req.body.phonenumbers,req.body.address],function(err,result){
        if(err) throw err;
        var sql = "SELECT * FROM `customers` WHERE `customerID` = "+req.signedCookies.customerID;
    connection.query(sql,function(err,result){
        if(result){
            res.render('customer/profile',{
                user: result[0],
                alert: "Changed successfully"
            })
            return;
        }
    })
    })
}
module.exports.showCart = function(req,res){
    var userId = res.locals.user.customerID;
    var sql = "SELECT `products`.`productID`,`quantityInStock`,  `productName`,`buyPrice`,`amount`  FROM `cart` INNER JOIN `products` WHERE `cart`.`productID` = `products`.`productID` AND `cart`.`customerID` = "+req.signedCookies.customerID;
    //console.log(sql);
    connection.query(sql,function(err,result){
        if(err) throw err;
        res.render('customer/cart',{list_item : result})
    })
    
}
module.exports.logout= function(req,res){
    res.clearCookie("customerID")
    res.clearCookie("sessionId")
    res.redirect('/home')
}
//Add product to cart
module.exports.addProduct = function(req,res){
    var productId = req.params.id;
    var userId = res.locals.user.customerID
    var sql = "SELECT * FROM `cart` WHERE `customerID` = " + userId +" AND `productID` = "+ productId;
    connection.query(sql,function(err,result){
        if(result.length > 0){
            if(err ) throw err.stack;
            var waiting_order = result[0];
            var count = waiting_order.amount;      
            var add_sql = "UPDATE `cart` SET `amount` = ? WHERE `cart`.`customerID` = ? AND `cart`.`productID` = ?"
            var sql_2 = "SELECT `quantityInStock` FROM `products` WHERE `productID` = ?"
            
            connection.query(sql_2 , [productId],function(err,result){
                
                var quantityInStock = result[0].quantityInStock;
                if(count < quantityInStock){
                    connection.query(add_sql , [count + 1 , userId , productId] , function(err,result){
                        if(err) throw err.stack
                    })
                }
            })        
        }
        else {
            var add_sql = "INSERT INTO `cart` (`customerID`, `productID`, `amount`) VALUES (?, ?, ?)"
            connection.query(add_sql ,[userId,productId,1], function(err,result){
                if(err) throw err.stack
            })
        }
     }
    )
}
module.exports.deleteItem = function(req,res){
    var sql = "DELETE FROM `cart` WHERE `productID` = ?;"
    connection.query(sql,[req.params.id],function(err,result){
        if(err) throw err;
        res.redirect('back')
    })
}
module.exports.editAmount = function(req,res){
    var newAmount = req.body.amount
    var customerID = req.signedCookies.customerID;
    var productID = req.params.id;
    var sql = "UPDATE `cart` SET `amount` = ? WHERE `productID` = ? AND `customerID` = ?;"
    connection.query(sql,[newAmount , productID , customerID],function(err,result){
        if(err) throw err;
    })
}
module.exports.order = function(req,res){
    //console.log(req.signedCookies.customerID);
    var sql = "SELECT `username`,`customerName`,`phoneNumber`,`address` FROM `customers` WHERE `customerID` = " + req.signedCookies.customerID;
    connection.query(sql,function(err,result){
        var user = result[0];
        var sql_2 = "SELECT `products`.`productID`,`quantityInStock`,  `productName`,`buyPrice`,`amount`,(`buyPrice`*`amount`) AS total  FROM `cart` INNER JOIN `products` WHERE `cart`.`productID` = `products`.`productID` AND `cart`.`customerID` = "+req.signedCookies.customerID;
        connection.query(sql_2 , function(err,result_2){
            var total = result_2.reduce(function(t,item){
                return t += item.total;
            },0)
            res.render('customer/order' , {user: user , list_item : result_2,total_price:total.toFixed(2)})
        })
    })
    
}
module.exports.submitOrder = function(req,res){
    var id = shortid.generate()
    var sql = "SELECT `customerID`, `cart`.`productID`,`amount`, `buyPrice` FROM `cart` INNER JOIN `products` ON `cart`.`productID` = `products`.`productID` WHERE `cart`.`customerID` = " + req.signedCookies.customerID;
    var now = new Date()
    var month = now.getMonth() + 1;
    var date = now.getDate();
    var year = now.getFullYear();
    var today = year + "-" + month + "-" +date
    var sql_orders = "INSERT INTO `orders` (`orderCode`, `orderDate`, `shippedDate`, `status`, `customerID`) VALUES (NULL, ?, NULL , 'Shipping', ?)"
    connection.query(sql_orders ,[today,req.signedCookies.customerID], function(err,result){
        connection.query("SELECT * FROM `orders` ORDER BY orderCode DESC LIMIT 1" , function(err,result){
            var id = result[0].orderCode;
            
            connection.query(sql,function(err,result){
                //console.log(result);
                for(var i of result){
                    var orderCode = id;
                    var productID = i.productID,amount = i.amount , buyPrice = i.buyPrice;
                    var sql_orderdetail = "INSERT INTO `orderdetails`(`orderCode`, `productID`, `amount`, `buyPrice`) VALUES (?,?,?,?)";
                    connection.query(sql_orderdetail , [orderCode,productID,amount,buyPrice],function(err,result){
                        if(err) throw err;
                    })
                    var sql_clearcart ="DELETE FROM `cart` WHERE `customerID`= " + req.signedCookies.customerID;
                    connection.query(sql_clearcart)
                }

            })
        })
    })
    //res.redirect('/home')
    res.render('customer/success')

}