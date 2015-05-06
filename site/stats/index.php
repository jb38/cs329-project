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
              <td><a href="">Show Query</a></td>
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
              <td><a href="">Show Query</a></td>
            </tr>
            <tr>
              <td>Average Driver Experience</td>
              <td>
              
                <?php
                
                  $sql = "select ( avg( datediff( now(), hire_date ) ) ) / 365.25 as AverageExp from driver";
                  
                  $stmt = $pdo->query($sql);
    
                  while($row = $stmt->fetch()) {
                      echo $row["AverageExp"] . " years";
                  }
                
                ?>
              
              </td>
              <td><a href="">Show Query</a></td>
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
              <td><a href="">Show Query</a></td>
            </tr>
          </tbody>
        </table>
        
      </div>
    </div>
    
    <script src="../vendor/jquery/jquery.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.js"></script>
    
  </body>
</html> 
