const mysql = require('mysql')
var connection = mysql.createConnection({
    host:'remotemysql.com',
    user:'ELrZj5Kl3j',
    password:'NlHUf2R02y',
    database:'ELrZj5Kl3j',
    charset:'utf8_general_ci'
  })
  // var connection = mysql.createConnection({
  //   host:'localhost',
  //   user:'root',
  //   password:'',
  //   database:'cellphoneshopdb',
  //   charset:'utf8_general_ci'
  // })
module.exports = connection;