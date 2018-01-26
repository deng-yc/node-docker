var express = require('express');
var fetch = require('node-fetch');

var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {

 
    res.render('index', { title: 'Express:' });

});

router.get("/test",function(req,res){
  fetch("http://hicoin-web-app:3000/test").then(req=>{
    return req.json()
  }).then(json=>{    
      res.json(json);
  })
})

module.exports = router;
