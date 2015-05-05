<?php
  
  include "../database.php";
  
  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
    
    $datetime = $_POST["datetime"];
    $latitude = $_POST["latitude"];
    $longitude = $_POST["longitude"];
    
    $sql = "insert into safety_incident (datetime, latitude, longitude) values (:datetime, :latitude, :longitude)";
   
    $stmt = $pdo->prepare($sql);
    $stmt->execute(array(":datetime"  => $datetime, 
                         ":latitude"  => $latitude,
                         ":longitude" => $longitude));
    
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
      
        <h1>New Safety Incident</h1>
        
        <form class="form form-horizontal" method="POST" action="new.php">
          	
          <div class="form-group">
            <label class="col-sm-2 control-label">Date/Time</label>
            <div class="col-sm-4">
              <input class="form-control" type="text" name="datetime">
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Latitude</label>
            <div class="col-sm-4">
              <input class="form-control" type="text" name="latitude">
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Longitude</label>
            <div class="col-sm-4">
              <input class="form-control" type="text" name="longitude">
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