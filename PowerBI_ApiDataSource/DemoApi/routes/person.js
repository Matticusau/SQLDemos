//
// Author: Matt Lavery
// Date: 2018-07-06
// Purpose: Person route
//
// Who          When            What
// ---------------------------------------------------------------------------

// import express
var express = require('express');
var apiRoutes = express.Router();

// sample data
var personData = [
    {
        "PersonID": "1",
        "LastName": "Abercrombie",
        "FirstName": "Kim",
        "HireDate": "1995-03-11 00:00:00.000",
        "EnrollmentDate": null
    },
    {
        "PersonID": "4",
        "LastName": "Fakhouri",
        "FirstName": "Fadi",
        "HireDate": "2002-08-06 00:00:00.000",
        "EnrollmentDate": null
    },
    {
        "PersonID": "5",
        "LastName": "Harui",
        "FirstName": "Roger",
        "HireDate": "1998-07-01 00:00:00.000",
        "EnrollmentDate": null
    },
    {
        "PersonID": "18",
        "LastName": "Zheng",
        "FirstName": "Roger",
        "HireDate": "2004-02-12 00:00:00.000",
        "EnrollmentDate": null
    },
    {
        "PersonID": "25",
        "LastName": "Kapoor",
        "FirstName": "Candace",
        "HireDate": "2001-01-15 00:00:00.000",
        "EnrollmentDate": null
    },
    {
        "PersonID": "27",
        "LastName": "Serrano",
        "FirstName": "Stacy",
        "HireDate": "1999-06-01 00:00:00.000",
        "EnrollmentDate": null
    },
    {
        "PersonID": "31",
        "LastName": "Stewart",
        "FirstName": "Jasmine",
        "HireDate": "1997-10-12 00:00:00.000",
        "EnrollmentDate": null
    },
    {
        "PersonID": "32",
        "LastName": "Xu",
        "FirstName": "Kristen",
        "HireDate": "2001-07-23 00:00:00.000",
        "EnrollmentDate": null
    },
    {
        "PersonID": "34",
        "LastName": "Van Houten",
        "FirstName": "Roger",
        "HireDate": "2000-12-07 00:00:00.000",
        "EnrollmentDate": null
    }
];

/* GET persons. */
apiRoutes.get('/', function (req, res) {
    var data = personData;
    res.json(data);
    console.log('route /person - complete');
});

/* GET persons by personid. */
apiRoutes.get('/:personid', function (req, res) {
    var data = personData;
    console.log('id param: '+JSON.stringify(req.params.personid));
    const result = data.find( person => person.PersonID === req.params.personid );
    res.json(result);
    console.log('route /person/:id - complete');
});

// export/return the routes to the server/caller
module.exports = apiRoutes;
