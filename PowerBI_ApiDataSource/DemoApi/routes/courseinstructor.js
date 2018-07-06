//
// Author: Matt Lavery
// Date: 2018-07-06
// Purpose: CourseInstructor route
//
// Who          When            What
// ---------------------------------------------------------------------------

// import express
var express = require('express');
var apiRoutes = express.Router();

// sample data
var instructorData = [
    {
      "CourseID": "1045",
      "PersonID": "5"
    },
    {
      "CourseID": "1050",
      "PersonID": "1"
    },
    {
      "CourseID": "1061",
      "PersonID": "31"
    },
    {
      "CourseID": "2021",
      "PersonID": "27"
    },
    {
      "CourseID": "2030",
      "PersonID": "4"
    },
    {
      "CourseID": "2042",
      "PersonID": "25"
    },
    {
      "CourseID": "4022",
      "PersonID": "18"
    },
    {
      "CourseID": "4041",
      "PersonID": "32"
    },
    {
      "CourseID": "4061",
      "PersonID": "34"
    }
];

/* GET courseinstructors. */
apiRoutes.get('/', function (req, res) {
    var data = instructorData;
    res.json(data);
    console.log('route /courseinstructors - complete');
});

// export/return the routes to the server/caller
module.exports = apiRoutes;
