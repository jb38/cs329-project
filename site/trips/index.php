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
      
        <h1>Trips</h1>
        
        <div class="text-right">
          <a class="btn btn-primary" href="new.php">New</a>
        </div>
        
        <table class="table table-striped">
          <thead>
            <tr>
              <th>ID</th>
              <th>Rider ID</th>
              <th>Entry Date and Time</th>
              <th>Exit Date and Time</th>
              <th>Entry Stop</th>
              <th>Exit Stop</th>
              <th>Cost</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            
            <?php
  
              $sql = "select id, rider_id, entry_datetime, exit_datetime, entry_stop, exit_stop, cost from trip order by id";
   
              $stmt = $pdo->query($sql);
  
              while($row = $stmt->fetch()) {
                
                echo("<tr data-id='" . $row["id"] . "'><td>" . $row["id"] . "</td><td>" . $row["rider_id"]  . "</td><td>" . $row["entry_datetime"] . "</td><td>" . $row["exit_datetime"] . "</td><td>" . $row["entry_stop"] . "</td><td>" . $row["exit_stop"] . "</td><td>" . $row["cost"] . "</td><td>");
                echo("<a href='edit.php?id=" . $row["id"] . "'>Edit</a>&nbsp;");
                echo("<a href='delete.php?id=" . $row["id"] . "'>Delete</a>");
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
