<?php
  
  include "../database.php";
  
  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
    
    $capacity = $_POST["capacity"];
    $type = $_POST["type"];
    
    $sql = "insert into vehicle (capacity, type) values (:capacity, :type)";
   
    $stmt = $pdo->prepare($sql);
    $stmt->execute(array(":capacity" => $capacity, 
                         ":type"     => $type));
    
    //header("Location: index.php");
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
          <a class="navbar-brand" href="../index.php">Transportation Website</a>
        </div>
      </div>
    </nav>
    
    <div class="container">
      <div class="col-sm-12">
      
        <h1>New Vehicle</h1>
        
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
              
                  $sql = "select id, description from vehicle_type order by description";
       
                  $stmt = $pdo->query($sql);
      
                  while($row = $stmt->fetch()) {
                    echo("<option value='" . $row["id"] . "'>" . $row["description"] . "</option>"); 
                  }
                  
                ?>
                
              </select>
            </div>
          </div>
          
          <div class="form-group">
            <div class="col-sm-6 text-right">
              <button class="btn btn-primary">Create</button>
              <a class="btn btn-link" href="index.php">Cancel</a>
            </div>
          </div>
        	
        </form>
        
      </div>
    </div>
    
    <script src="../vendor/jquery/jquery.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.js"></script>
    
  </body>
</html> 