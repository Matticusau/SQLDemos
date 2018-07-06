//
// Author: Matt Lavery
// Date: 2018-07-06
// Purpose: Course route
//
// Who          When            What
// ---------------------------------------------------------------------------

// import express
var express = require('express');
var apiRoutes = express.Router();

// sample data
var courseData = [
    {
        "CourseID": "1045",
        "Title": "Calculus",
        "Credits": "4",
        "DepartmentID": "7"
    },
    {
        "CourseID": "1050",
        "Title": "Chemistry",
        "Credits": "4",
        "DepartmentID": "1"
    },
    {
        "CourseID": "1061",
        "Title": "Physics",
        "Credits": "4",
        "DepartmentID": "1"
    },
    {
        "CourseID": "2021",
        "Title": "Composition",
        "Credits": "3",
        "DepartmentID": "2"
    },
    {
        "CourseID": "2030",
        "Title": "Poetry",
        "Credits": "2",
        "DepartmentID": "2"
    },
    {
        "CourseID": "2042",
        "Title": "Literature",
        "Credits": "4",
        "DepartmentID": "2"
    },
    {
        "CourseID": "3141",
        "Title": "Trigonometry",
        "Credits": "4",
        "DepartmentID": "7"
    },
    {
        "CourseID": "4022",
        "Title": "Microeconomics",
        "Credits": "3",
        "DepartmentID": "4"
    },
    {
        "CourseID": "4041",
        "Title": "Macroeconomics",
        "Credits": "3",
        "DepartmentID": "4"
    },
    {
        "CourseID": "4061",
        "Title": "Quantitative",
        "Credits": "2",
        "DepartmentID": "4"
    }
];

/* GET courses. */
apiRoutes.get('/', function (req, res) {
    var data = courseData;
    res.json(data);
    console.log('route /course - complete');
});

/* GET courses by courseid. */
apiRoutes.get('/:courseid', function (req, res) {
    var data = courseData;
    const result = data.find( course => course.CourseID === req.params.courseid );
    res.json(result);
    console.log('route /course/:id - complete');
});

// export/return the routes to the server/caller
module.exports = apiRoutes;
