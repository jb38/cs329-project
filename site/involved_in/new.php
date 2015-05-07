<?php
  
  include "../database.php";
  
  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
    
    $vehicle_id = $_POST["vehicle_id"];
    $incident_id = $_POST["incident_id"];
    $at_fault = $_POST["at_fault"];
    
    $sql = "insert into involved_in (vehicle_id, incident_id, at_fault) values (:vehicle_id, :incident_id, :at_fault)";
   
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
      
        <h1>New Safety Incident Involvement</h1>
        
        <form class="form form-horizontal" method="POST" action="new.php">
          	
          <div class="form-group">
            <label class="col-sm-2 control-label">Vehicle ID</label>
            <div class="col-sm-4">
              <select class="form-control" name="vehicle_id">
                
                <?php
              
                  $sql = "select v.id, description from vehicle v, vehicle_type t where v.type = t.id order by id";
       
                  $stmt = $pdo->query($sql);
      
                  while($row = $stmt->fetch()) {
                    echo("<option value='" . $row["id"] . "'>" . $row["description"] . "(". $row["id"] . ")</option>"); 
                  }
                  
                ?>
                
              </select>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Incident ID</label>
            <div class="col-sm-4">
              <select class="form-control" name="incident_id">
                
                <?php
              
                  $sql = "select id, datetime from safety_incident order by id";
       
                  $stmt = $pdo->query($sql);
      
                  while($row = $stmt->fetch()) {
                    echo("<option value='" . $row["id"] . "'>" . $row["datetime"] . "</option>"); 
                  }
                  
                ?>
                
              </select>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">At Fault</label>
            <div class="col-sm-4">
              <select class="form-control" name="at_fault">
                <option value="1">Yes</option>
                <option value="0">No</option>
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