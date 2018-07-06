//
// Author: Matt Lavery
// Date: 2018-07-06
// Purpose: Server entry
//
// Who          When            What
// ---------------------------------------------------------------------------
//

// =======================
// get the packages we need
// =======================
var express     = require('express');
var app         = express();

// server.js
var port = process.env.PORT || 3000;
// var server = app.listen(port, function() {
//   console.log('PowerBI  listening on port ' + port);
// });

// get an instance of the router for api routes
var apiRoutes = express.Router(); 

// route to show a random message (GET http://localhost:8080/api/)
apiRoutes.get('/', function(req, res) {
  res.json({ message: 'Welcome to the coolest API on earth!' });
});

// apply the routes to our application with the prefix /api
app.use('/api/', apiRoutes);

// our custom routes
app.use('/api/person', require('./routes/person'));
app.use('/api/course', require('./routes/course'));
app.use('/api/courseinstructor', require('./routes/courseinstructor'));

// =======================
// start the server ======
// =======================
app.listen(port);
console.log('Magic happens at http://localhost:' + port);