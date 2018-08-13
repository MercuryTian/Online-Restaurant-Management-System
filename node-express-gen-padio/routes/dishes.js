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

    //console.log('The solution ');
    console.log(req.baseUrl);
    console.log(req.query);
    console.log(req.query.what);
    if (req.query.what == 'best') {
        connection.query('SELECT * FROM menu WHERE price = 68', function(err, rows, fields) {
        if (err) {
          console.log('The solution ');
          throw err;
        }

        res.send([{
          name: rows[0].menu_name,
          label: rows[0].type,
          price: rows[0].price,
          description: rows[0].descript,
          image: "http://localhost:3000/app/images/"+rows[0].menu_name+".jpg"
        }]);

        console.log('The solution is: ', rows[0].menu_name);
    });
    }
    else if (req.query.what == 'all') {
        connection.query('SELECT * FROM menu', function(err, rows, fields) {
        if (err) {
          console.log('The solution ');
          throw err;
        }
        var menu_dishes = new Array();
        for(var i in rows){
            menu_dishes.push(
                {
                    name: rows[i].menu_name,
                    label: rows[i].type,
                    price: rows[i].price,
                    description: rows[i].descript,
                    image: "http://localhost:3000/app/images/"+rows[i].menu_name+".jpg"
                }
            )
        }

        console.log(menu_dishes[0]);
        res.send(menu_dishes);

        //console.log('The solution is: ', rows[0].menu_name);
    });
    }
    else{
        res.send([{nothing:"nothing"}]);
    }
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
