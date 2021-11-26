const express = require("express");
const app = express();

const sql = require("mssql/msnodesqlv8");
const config = require('./dbconfig')


app.get('/', function (req, res) {
    sql.connect(config).then(() => {
        var request = new sql.Request();
        request.query('SELECT * FROM USERTB', (err, result) => {
            res.send(result.recordset);
        })
    }).catch(function(err) {
        console.log(err)
    });
});

app.get('/course', function (req, res) {
    sql.connect(config).then(() => {
        var request = new sql.Request();
        request.query(`SELECT * FROM COURSE`, (err, result) => {
            res.send(result.recordset);
        })
    }).catch(function(err) {
        console.log(err)
    });
});

app.get('/course/:id', function (req, res) {
    sql.connect(config).then(() => {
        var request = new sql.Request();
        request.query(`SELECT * FROM COURSE WHERE Course_ID = ${req.params.id}`, (err, result) => {
            res.send(result.recordset);
        })
    }).catch(function(err) {
        console.log(err)
    });
});


app.listen(3001, function() {
    console. log("express server is running on port 3001");
});
