var express = require('express');
var fetch = require('node-fetch');

var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {

  fetch({
    url:"http://webapi:3000/test"
  }).then(req=>{
    return req.json()
  }).then(json=>{
    res.render('index', { title: 'Express:'+json.url,now:json.now });
  })

});

module.exports = router;
