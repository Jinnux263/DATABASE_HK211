import express from "express";
import dotenv from "dotenv";
//import DBconnect from './DBconnect.js';
// import colors from "colors";
import config from "./dbconfig.js";
import sql from "mssql/msnodesqlv8.js";

dotenv.config();
const app = express();

app.get("/", function (req, res) {
  res.send("API is running...");
});

app.get("/api/courses", function (req, res) {
  sql
    .connect(config)
    .then(() => {
      var request = new sql.Request();
      request.query(`SELECT * FROM COURSE`, (err, result) => {
        res.send(result.recordset);
      });
    })
    .catch(function (err) {
      console.log(err);
    });
});

app.get("/api/course/:id", function (req, res) {
  sql
    .connect(config)
    .then(() => {
      var request = new sql.Request();
      request.query(
        `SELECT * FROM COURSE WHERE Course_ID = ${req.params.id}`,
        (err, result) => {
          res.send(result.recordset);
        }
      );
    })
    .catch(function (err) {
      console.log(err);
    });
});

app.use(express.json());
//app.use(express.urlencoded());

app.post("/api/courses/insert", function (req, res) {
  console.log("Server Inserting...");
  sql
    .connect(config)
    .then(() => {
      var request = new sql.Request();
      const items = req.body.item;
      const msg = `INSERT INTO COURSE VALUES ('${items.Course_ID}','${items.Course_name}','${items.SPECIALIZATION}','${items.Level}','${items.Description}',${items.Fee},'${items.Admin_ID}');`;
      //console.log(msg)
      request.query(msg);
      console.log("Server Insert success!");
    })
    .catch(function (err) {
      console.log(err);
    });
});

app.post("/api/courses/update", function (req, res) {
  console.log("Server Updating...");
  sql
    .connect(config)
    .then(() => {
      var request = new sql.Request();
      const items = req.body.item;
      const msg = `UPDATE COURSE SET Course_name = '${items.Course_name}', SPECIALIZATION = '${items.SPECIALIZATION}', Level = '${items.Level}', Description = '${items.Description}', Fee = ${items.Fee}, Admin_ID = '${items.Admin_ID}' WHERE Course_ID = '${items.Course_ID}';`;
      //console.log(msg)
      request.query(msg);
      console.log("Server update success!");
    })
    .catch(function (err) {
      console.log(err);
    });
});

app.post("/api/courses/delete", function (req, res) {
  console.log("Server Deleting...");
  sql
    .connect(config)
    .then(() => {
      var request = new sql.Request();
      const items = req.body.ID;
      const msg = `DELETE FROM COURSE WHERE Course_ID = '${items}';`;
      //console.log(msg)
      request.query(msg);
      console.log("Server delete success!");
    })
    .catch(function (err) {
      console.log(err);
    });
});

const PORT = process.env.PORT || 3001;

app.listen(
  PORT,
  console.log(
    `express server is running in ${process.env.NODE_ENV} mode on port ${PORT}`
    // .yellow.bold
  )
);
