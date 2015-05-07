<?php
  
  include "../database.php";
  
  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
    
    $vehicle_id = $_POST["vehicle_id"];
    $incident_id = $_POST["incident_id"];
    
    $sql = "delete from involved_id where vehicle_id = :vehicle_id and incident_id = :incident_id";
  
    $stmt = $pdo->prepare($sql);
    $stmt->execute(array(":vehicle_id"  => $vehicle_id,
                         ":incident_id" => $incident_id));
    
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
        
        <h1>Delete Safety Incident Involvement</h1>
        
        <form class="form form-horizontal" method="POST" action="delete.php">
          
          <?php
            
            $vehicle_id = $_GET["vehicle_id"];
            $incident_id = $_GET["incident_id"];
            
            $sql = "select vehicle_id, incident_id, at_fault from involved_in where vehicle_id = :vehicle_id and order by vehicle_id";
 
            $stmt = $pdo->prepare($sql);
  	        $stmt->execute(array(":vehicle_id"  => $vehicle_id,
                                 ":incident_id" => $incident_id));
            
            $row = $stmt->fetch();
            
          ?>
          	
          <input type="hidden" name="vehicle_id" value="<?php echo($row["vehicle_id"]); ?>">
          <input type="hidden" name="incident_id" value="<?php echo($row["incident_id"]); ?>">
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Vehicle ID</label>
            <div class="col-sm-4">
              <p class="form-control-static"><?php echo($row["vehicle_id"]); ?></p>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Incident ID</label>
            <div class="col-sm-4">
              <p class="form-control-static"><?php echo($row["incident_id"]); ?></p>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">At Fault?</label>
            <div class="col-sm-4">
              <p class="form-control-static"><?php echo($row["at_fault"]); ?></p>
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