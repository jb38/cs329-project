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
      
        <h1>Safety Incident Involvements</h1>
        
        <div class="text-right">
          <a class="btn btn-primary" href="new.php">New</a>
        </div>
        
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Vehicle ID</th>
              <th>Incident ID</th>
              <th>At Fault?</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            
            <?php
  
              $sql = "select vehicle_id, incident_id, at_fault from involved_in order by vehicle_id";
   
              $stmt = $pdo->query($sql);
  
              while($row = $stmt->fetch()) {
                
                echo("<tr data-id='" . $row["vehicle_id"] . "'><td>" . $row["vehicle_id"] . "</td><td>" . $row["incident_id"] . "</td><td>" . ($row["at_fault"] === "1" ? "Yes" : "No")  . "</td><td>");
                echo("<a href='edit.php?vehicle_id=" . $row["vehicle_id"] . "&incident_id=" . $row["incident_id"] . "'>Edit</a>&nbsp;");
                echo("<a href='delete.php?vehicle_id=" . $row["vehicle_id"] . "&incident_id=" . $row["incident_id"] .  "'>Delete</a>");
                echo("</td></tr>\n");
              }
              
            ?>
            
          </tbody>
        </table>
        
      </div>
    </div>
    
    <script src="../vendor/jquery/jquery.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.js"></script>
    
  </body>
</html> 
