var express = require('express');
var fetch = require('node-fetch');
var os = require('os')
var path = require('path');
var fs = require("fs");
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    fs.writeFileSync("/data/1.txt",os.hostname());
    res.render('index', { title: os.hostname() });
});

module.exports = router;
