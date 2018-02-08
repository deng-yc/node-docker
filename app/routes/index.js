var express = require('express');
var fetch = require('node-fetch');
var os = require('os')
var path = require('path');
var fs = require("fs");
var router = express.Router();

var ip = require("ip");



/* GET home page. */
router.get('/', function(req, res, next) {
    var lastTitle="";
    var os_name=os.hostname();
    res.render('index', { title: os_name,last_title:ip.address() });
});

module.exports = router;
