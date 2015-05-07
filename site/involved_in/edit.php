<?php
  
  include "../database.php";
  
  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
    
    $vehicle_id = $_POST["vehicle_id"];
    $incident_id = $_POST["incident_id"];
    $at_fault = $_POST["at_fault"];
    
    $sql = "update involved_in set at_fault = :at_fault where vehicle_id = :vehicle_id and incident_id = :incident_id";
   
    $stmt = $pdo->prepare($sql);
    $stmt->execute(array(":vehicle_id"  => $vehicle_id, 
                         ":incident_id" => $incident_id,
                         ":at_fault"    => $at_fault));
    
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
        
        <h1>Edit Safety Incident Involvement</h1>
        
        <form class="form form-horizontal" method="POST" action="edit.php">
          
            <?php
            
              $vehicle_id = $_GET["vehicle_id"];
              $incident_id = $_GET["incident_id"];
              
              $sql = "select vehicle_id, incident_id, at_fault from involved_in where vehicle_id = :vehicle_id and incident_id = :incident_id order by vehicle_id";
   
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
                <select class="form-control" name="at_fault">
                  <option value="1" <?php echo($row["at_fault"] === "1" ? "selected" : "") ?>>Yes</option>
                  <option value="0" <?php echo($row["at_fault"] === "0" ? "selected" : "") ?>>No</option>
                </select>
              </div>
            </div>
            
            <div class="form-group text-right">
              <div class="col-sm-6">
                <button class="btn btn-primary">Update</button>
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