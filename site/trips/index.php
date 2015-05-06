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
              <th>Rider Name</th>
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
  
              $sql = "select t.id, t.rider_id, t.entry_datetime, t.exit_datetime, t.entry_stop, t.exit_stop, t.cost, r.name as rider_name, fs.name as entry_stop_name, ls.name as exit_stop_name from trip t join rider r on t.rider_id = r.id join stop fs on t.entry_stop = fs.id join stop ls on t.exit_stop = ls.id order by t.id";
   
              $stmt = $pdo->query($sql);
  
              while($row = $stmt->fetch()) {
                
                echo("<tr data-id='" . $row["id"] . "'><td>" . $row["id"] . "</td><td>" . $row["rider_name"]  . "</td><td>" . $row["entry_datetime"] . "</td><td>" . $row["exit_datetime"] . "</td><td>" . $row["entry_stop_name"] . "</td><td>" . $row["exit_stop_name"] . "</td><td>$" . $row["cost"] . "</td><td>");
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
