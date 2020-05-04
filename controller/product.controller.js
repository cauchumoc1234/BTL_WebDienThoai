const connection = require('../db')
module.exports.search = function(req,res){
    var q = req.query.q;
    let sql = "SELECT * FROM `products` WHERE productName LIKE '%"+q+"%'"
   connection.query(sql,function(err,result){
       res.render('option/search',{
           products:result,
           searchFor:req.query.q
       })
    //res.send(result)
   })
}