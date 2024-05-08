const express = require('express')
const mysql = require('mysql2');

const app = express();

const dbconnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'apinopfocus2546',
    database: 'exchange_db',
    port: '3306'
  });
  
  dbconnection.connect((err) => {
    if(err) {
      console.log('Error connecting to MySQL database', err);
      return;
    }
      console.log('MySQL successfully connected');
  });

module.exports = dbconnection;

