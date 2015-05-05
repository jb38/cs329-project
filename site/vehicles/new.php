<?php
  include '../database.php';
  
  if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    // TODO grab the values and perform the update
    
  }
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
      
      <h1>Edit Vehicle</h1>
      
      <form class="form form-horizontal" method="POST" action="edit.php">
        	
          <div class="form-group">
            <label class="col-sm-2 control-label">Capacity</label>
            <div class="col-sm-4">
              <input class="form-control" type="number" name="capacity" value="40">
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Type</label>
            <div class="col-sm-4">
              <select class="form-control" name="type">
                
                <?php
                  
                  $conn = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
              
                  $sql = "select id, description from vehicle_type order by description";
       
                  $stmt = $conn->query($sql);
                  $stmt->setFetchMode(PDO::FETCH_NUM);
      
                  while($row = $stmt->fetch()) {
                    echo("<option value='" . $row[0] . "'>" . $row[1] . "</option>"); 
                  }
                  
                ?>
                
              </select>
            </div>
          </div>
          
          <div class="form-group">
            <div class="col-sm-6 text-right">
              <button class="btn btn-primary">Apply</button>
              <a class="btn btn-link" href="index.php">Cancel</a>
            </div>
          </div>	
      </form>
        
    </div>
    
    <script src="../vendor/jquery/jquery.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.js"></script>
    
  </body>
</html> 