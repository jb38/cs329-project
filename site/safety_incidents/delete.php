<?php
  
  include "../database.php";
  
  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
    
    $incident_id = $_POST["id"];
    
    $sql = "delete from safety_incident where id = :incident_id";
  
    $stmt = $pdo->prepare($sql);
    $stmt->execute(array(":incident_id" => $incident_id));
    
    header("Location: index.php");  
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
        
        <h1>Delete Safety Incident</h1>
        
        <form class="form form-horizontal" method="POST" action="delete.php">
          
          <?php
            
            $incident_id = $_GET["id"];
              
            $sql = "select id, datetime, latitude, longitude from safety_incident where id = :incident_id";
  
            $stmt = $pdo->prepare($sql);
            $stmt->execute(array(":incident_id" => $incident_id));
            
            $row = $stmt->fetch();
            
          ?>
          	
          <input type="hidden" name="id" value="<?php echo($row["id"]); ?>">
          
          <div class="form-group">
            <label class="col-sm-2 control-label">ID</label>
            <div class="col-sm-4">
              <p class="form-control-static"><?php echo($row["id"]); ?></p>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Date/Time</label>
            <div class="col-sm-4">
              <p class="form-control-static"><?php echo($row["datetime"]); ?></p>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Latitude</label>
            <div class="col-sm-4">
              <p class="form-control-static"><?php echo($row["latitude"]); ?></p>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Longitude</label>
            <div class="col-sm-4">
              <p class="form-control-static"><?php echo($row["longitude"]); ?></p>
            </div>
          </div>
          
          <div class="form-group text-right">
            <div class="col-sm-6">
              <button class="btn btn-danger">Delete</button>
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