var express = require('express');
var fetch = require('node-fetch');
var os = require('os')
var path = require('path');
var fs = require("fs");
var router = express.Router();



function getLocalIPv4(){

  var os = require('os');
    var interfaces = os.networkInterfaces();
    var IPv4 = '127.0.0.1';
    for (var key in interfaces) {
      var alias = 0;
      interfaces[key].forEach(function(details){
        if (details.family == 'IPv4' && key == 'en0'  ) {
            IPv4 = details.address;
        }
      });
    }
    return IPv4;
}

/* GET home page. */
router.get('/', function(req, res, next) {
    var lastTitle="";
    var os_name=os.hostname();
    var ip=getLocalIPv4();
    res.render('index', { title: os_name,last_title:ip });
});

module.exports = router;
