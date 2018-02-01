var express = require('express');
var fetch = require('node-fetch');
var os = require('os')
var path = require('path');
var fs = require("fs");
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    var lastTitle="";
    var os_name=os.hostname();
    if(fs.existsSync("/data/1.txt")){
      lastTitle=fs.readFileSync("/data/1.txt",'utf-8');
    }     
    fs.writeFileSync("/data/1.txt",os_name);
    res.render('index', { title: os_name,last_title:lastTitle });
});

module.exports = router;
