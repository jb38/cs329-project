<?php
  include '../database.php';
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
          <a class="navbar-brand" href="index.php">Transportation Website</a>
        </div>
      </div>
    </nav>
    
    <div class="container">
      
      <h1>Vehicles</h1>
      
      <table class="table">
        <thead>
          <th>
            <td>ID</td>
            <td>Capacity</td>
            <td>Type</td>
            <td></td>
          </th>
        </thead>
        <tbody>
          
          <?php
            
            $conn = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
            $sql = "select v.id, v.capacity, v.type, t.description from vehicle v, vehicle_type t where v.type = t.id";
 
            $stmt = $conn->query($sql);
            $stmt->setFetchMode(PDO::FETCH_NUM);

            while($row = $stmt->fetch()) {
              echo("<tr data-id='" . $row[0] . "'><td>" . $row[0] . "</td><td>" . $row[1]  . "</td><td    >" . $row[3] . "</td>");
              echo("<a class='btn btn-link' href='edit.php?id=" . $row[0] . "'>Edit</a>");
              echo("<a class='btn btn-link' href='delete.php?id=" . $row[0] . "'>Delete</a>");
              echo("</tr>\n");
            }
            
          ?>
          
        </tbody>
      </table>
    </div>
    
    <script src="../vendor/jquery/jquery.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.js"></script>
    
  </body>
</html> 