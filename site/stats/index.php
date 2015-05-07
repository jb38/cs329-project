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
              <td><code>SELECT count(1) as TotalRiders FROM rider</code></td>
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
              <td><code>SELECT count(1) as TotalDrivers FROM driver</code></td>
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
              <td><code>SELECT (avg(datediff(now(), hire_date))) / 365.25 as AverageExp FROM driver</code></td>
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
              <td><code>SELECT count(1) as TotalTrips FROM trip</code></td>
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
              <td><code>SELECT avg(cost) as AverageCost FROM trip</code></td>
            </tr>
            <tr>
              <td>Top Three Problem Drivers</td>
              <td>
              
                <?php
                
                  $sql = "select d.name as BadDriver, count(1) as NumAccidents from involved_in i 
                          left join operates o on i.vehicle_id = o.vehicle_id
                          left join driver d on o.driver_id = d.id
                          group by d.name
                          order by NumAccidents DESC
                          limit 3";
                  
                  $stmt = $pdo->query($sql);
    
                  while($row = $stmt->fetch()) {
                      echo $row["BadDriver"] . " (" . $row["NumAccidents"] . ") ";
                  }
                
                ?>
              
              </td>
              <td><code>SELECT d.name AS BadDriver, count(1) AS NumAccidents FROM involved_in i 
                        LEFT JOIN operates o ON i.vehicle_id = o.vehicle_id
                        LEFT JOIN driver d ON o.driver_id = d.id
                        GROUP BY BadDriver
                        ORDER BY NumAccidents DESC
                        LIMIT 3</code></td>
            </tr>
          </tbody>
        </table>
        
      </div>
    </div>
    
    <script src="../vendor/jquery/jquery.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.js"></script>
    
  </body>
</html> 