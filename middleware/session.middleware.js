var shortId = require('shortid');
var connection = require('../db')
module.exports = function(req,res,next){
    if (!req.signedCookies.sessionId) {
		var sessionId = shortId.generate();
		res.cookie('sessionId', sessionId,{signed: true})
    }
    next();
}