<?php
  
  include "../database.php";
  
  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Transportation Website | CS329 Database Project</title>
    <link rel="stylesheet" href="../vendor/bootstrap/css/bootstrap.css">  
  </head>
  <body>
    
    <nav class="navbar navbar-default">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="../index.php">Transportation Website</a>
        </div>
      </div>
    </nav>
    
    <div class="container">
      <div class="col-sm-12">
      
        <h1>Database Statistics</h1>
        
        <table class="table table-striped">
          <tbody>
            <tr>
              <td>Total Number of Riders</td>
              <td>
              
                <?php
                
                  $sql = "select count(1) as TotalRiders from rider";
                  
                  $stmt = $pdo->query($sql);
    
                  while($row = $stmt->fetch()) {
                      echo $row["TotalRiders"];
                  }
                
                ?>
              
              </td>
              <td><pre>
SELECT 
  count(1) AS total_riders 
FROM 
  rider;</pre></td>
            </tr>
            <tr>
              <td>Total Number of Drivers</td>
              <td>
              
                <?php
                
                  $sql = "select count(1) as TotalDrivers from driver";
                  
                  $stmt = $pdo->query($sql);
    
                  while($row = $stmt->fetch()) {
                      echo $row["TotalDrivers"];
                  }
                
                ?>
              
              </td>
              <td><pre>
SELECT 
  count(1) AS total_drivers 
FROM
  driver;</pre></td>
            </tr>
            <tr>
              <td>Average Driver Experience</td>
              <td>
              
                <?php
                
                  $sql = "select ( avg( datediff( now(), hire_date ) ) ) / 365.25 as AverageExp from driver";
                  
                  $stmt = $pdo->query($sql);
    
                  while($row = $stmt->fetch()) {
                      echo number_format($row["AverageExp"], 2) . " years";
                  }
                
                ?>
              
              </td>
              <td><pre>
SELECT 
  (avg(datediff(now(), hire_date))) / 365.25 AS avg_exp 
FROM 
  driver;</pre></td>
            </tr>
            <tr>
              <td>Total Number of Trips</td>
              <td>
              
                <?php
                
                  $sql = "select count(1) as TotalTrips from trip";
                  
                  $stmt = $pdo->query($sql);
    
                  while($row = $stmt->fetch()) {
                      echo $row["TotalTrips"];
                  }
                
                ?>
              
              </td>
              <td><pre>
SELECT 
  count(1) AS total_trips 
FROM
  trip;</pre></td>
            </tr>
            <tr>
              <td>Average Trip Cost</td>
              <td>
              
                <?php
                
                  $sql = "select avg(cost) as AverageCost from trip";
                  
                  $stmt = $pdo->query($sql);
    
                  while($row = $stmt->fetch()) {
                      echo "$" . number_format($row["AverageCost"], 2);
                  }
                
                ?>
              
              </td>
              <td><pre>
SELECT 
  avg(cost) AS avg_cost 
FROM 
  trip;</pre></td>
            </tr>
            <tr>
              <td>Top Three Problem Drivers</td>
              <td>
                <ul class="list-unstyled">
                  <?php
                  
                    $sql = "select d.name as BadDriver, count(1) as NumAccidents from involved_in i 
                            left join operates o on i.vehicle_id = o.vehicle_id
                            left join driver d on o.driver_id = d.id
                            group by d.name
                            order by NumAccidents DESC
                            limit 3";
                    
                    $stmt = $pdo->query($sql);
      
                    while($row = $stmt->fetch()) {
                        echo "<li>" . $row["BadDriver"] . " (" . $row["NumAccidents"] . ")</li>";
                    }
                  
                  ?>
                </ul>
              </td>
              <td>
                <pre>
SELECT 
  d.name AS bad_driver
 ,count(1) AS num_accidents 
FROM 
  involved_in i 
  LEFT JOIN operates o ON (i.vehicle_id = o.vehicle_id)
  LEFT JOIN driver d ON (o.driver_id = d.id)
GROUP BY bad_driver
ORDER BY num_accidents DESC
LIMIT 3;</pre>
              </td>
            </tr>
          </tbody>
        </table>
        
      </div>
    </div>
    
    <script src="../vendor/jquery/jquery.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.js"></script>
    
  </body>
</html> 