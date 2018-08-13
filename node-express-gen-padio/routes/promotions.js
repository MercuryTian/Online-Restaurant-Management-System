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
    connection.query('SELECT * FROM menu WHERE price = 38', function(err, rows, fields) {
        if (err) {
          console.log('The solution ');
          throw err;
        }

        res.send([{
          name: rows[0].menu_name,
          label: "CEO",
          price: rows[0].price,
          description: "The best food!",
          image: "http://localhost:3000/app/images/"+rows[0].menu_name+".jpg"
        }]);

        console.log('The solution is: ', rows[0].menu_name);
    });
 
    //connection.release();
    //console.log('The solution ');
    
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
