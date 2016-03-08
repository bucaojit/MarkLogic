// Load documents into the database.

var marklogic = require('marklogic');
var my = require('./connection.js');
/*
  // Example of the connection parameters
  module.exports = {
    connection: {
      hosts: 'localhost',
      port: 8000, 
      user: '',
      password: ''
    }
  };
*/

var db = marklogic.createDatabaseClient(my.connection);

var documents = [
  { uri: '/nodejsTest/test.json',
    content: {
      value: 'Hello World'
    }
  },
  { uri: '/nodejsTest/secondTest.json',
    content: {
      value: 'Second Hello World'
    }
  },
];

db.documents.write(documents).result();
