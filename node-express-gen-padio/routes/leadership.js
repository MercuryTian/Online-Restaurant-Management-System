var express = require('express');
var bodyParser = require('body-parser');
var router = express.Router();

module.exports = router;

router.use(bodyParser.json());

var mysql      = require('mysql');
var connection = mysql.createPool({
  host     : 'localhost',
  user     : 'root',
  password : '121231996ini',
  database : 'restaurant'
});

router.route('/')
.get(function(req,res,next){
	//res.end(req);
    //res.end('Will send all the dishes to you!');
    //connection.connect();
    //console.log('The solution ');
    connection.query("SELECT * FROM staff WHERE position = 'SA'", function(err, rows, fields) {
        if (err) {
          console.log(err);
          throw err;
        }

        res.send([{
          name: rows[0].staff_name,
          label: rows[0].position,
          description: "Our story began in 1971. Back then we were a roaster and retailer of whole bean and ground coffee, tea and spices with a single store in Seattle’s Pike Place Market.Today, we are privileged to connect with millions of customers every day with exceptional products and more than 24,000 retail stores in 70 countries.",
          image: "http://localhost:3000/app/images/staff/"+rows[0].staff_name+".jpg"
        }]);

        console.log('The solution is: ', rows[0].staff_name);
    });
 
    //connection.release();
})

.post(function(req, res, next){
    res.end('Will add the dish: ' + req.body.name + ' with details: ' + req.body.description);    
})

.delete(function(req, res, next){
        res.end('Deleting all dishes');
});

router.route('/:id')
.all(function(req,res,next) {
      res.writeHead(200, { 'Content-Type': 'text/plain' });
      next();
})

.get(function(req,res,next){
        res.end('Will send details of the dish: ' + req.params.id +' to you!');
})

.put(function(req, res, next){
        res.write('Updating the dish: ' + req.params.dishId + '\n');
    res.end('Will update the dish: ' + req.body.name + 
            ' with details: ' + req.body.description);
})

.delete(function(req, res, next){
        res.end('Deleting dish: ' + req.params.dishId);
});
