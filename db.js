const mysql = require('mysql')
var connection = mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'',
    database:'cellphoneshopdb',
    charset:'utf8_general_ci'
  })
module.exports = connection;