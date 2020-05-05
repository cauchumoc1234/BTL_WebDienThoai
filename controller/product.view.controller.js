const connection = require('../db')
module.exports.view = function(req,res){
    //res.send(req.params.id)
    var productId = req.params.id;
    connection.query('SELECT * FROM products WHERE productID = '+productId,(err,result)=>{
        res.render('product',{
            product:result[0]
        })
        //res.send(result)
    })
}