const express = require("express");
const app = express();

const sql = require("mssql/msnodesqlv8");
const config = require('./dbconfig')
// const config = {
//     user: 'admin',
//     password: '123456',
//     database: 'ASSIGNMENT2',
//     server: 'MSI',
//     options: {
//         trustedConnection: true
//     }
// };

// const config = new sql.ConnectionPool({
//     login: 'admin',
//     password: '123456',
//     database: 'ASSIGNMENT2',
//     server: 'MSI',
//     driver: 'msnodesqlv8',
//     options: {
//         trustedConnection: true
//     }
// });



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


app.listen(3001, function() {
    console. log("express server is running on port 3001");
});




// var sql = require('mssql/msnodesqlv8');
// var config = {
//     connectionString: 'Driver=SQL Server;Server=localhost\\MSI;Database=master;Trusted_Connection=true;'
// };
// sql.connect(config, err => {
//     new sql.Request().query('SELECT 1 AS justAnumber', (err, result) => {
//         console.log(".:The Good Place:.");
//         if(err) { // SQL error, but connection OK.
//             console.log("  Shirtballs: "+ err);
//         } else { // All is rosey in your garden.
//             console.dir(result);
//         };
//     });
// });
// sql.on('error', err => { // Connection borked.
// console.log(".:The Bad Place:.");
// console.log("  Fork: "+ err);
// });
