<?php
  
  include "../database.php";
  
  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
    
    $rider_id = $_POST["rider_id"];
    $entry_datetime = $_POST["entry_datetime"];
    $exit_datetime = $_POST["exit_datetime"];
    $entry_stop = $_POST["entry_stop"];
    $exit_stop = $_POST["exit_stop"];
    $cost = $_POST["cost"];
    
    $sql = "insert into trip (rider_id, entry_datetime, exit_datetime, entry_stop, exit_stop, cost) values (:rider_id, :entry_datetime, :exit_datetime, :entry_stop, :exit_stop, :cost)";
   
    $stmt = $pdo->prepare($sql);
    $stmt->execute(array(":rider_id"      => $rider_id, 
                         ":entry_datetime" => $entry_datetime,
                         ":exit_datetime" => $exit_datetime,
                         ":entry_stop" => $entry_stop,
                         ":exit_stop" => $exit_stop,
                         ":cost" => $cost,));
    
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
      
        <h1>New Trip</h1>
        
        <form class="form form-horizontal" method="POST" action="new.php">
          	
          <div class="form-group">
            <label class="col-sm-2 control-label">Rider ID</label>
            <div class="col-sm-4">
              <input class="form-control" type="text" name="rider_id">
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Entry Date and Time</label>
            <div class="col-sm-4">
              <input class="form-control" type="text" name="entry_datetime">
            </div>
          </div>
		  
          <div class="form-group">
            <label class="col-sm-2 control-label">Exit Date and Time</label>
            <div class="col-sm-4">
              <input class="form-control" type="text" name="exit_datetime">
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Entry Stop</label>
            <div class="col-sm-4">
              <input class="form-control" type="text" name="entry_stop">
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Exit Stop</label>
            <div class="col-sm-4">
              <input class="form-control" type="text" name="exit_stop">
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Cost</label>
            <div class="col-sm-4">
              <input class="form-control" type="text" name="cost">
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