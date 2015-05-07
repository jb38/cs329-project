<?php
  
  include "../database.php";
  
  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
    
    $incident_id = $_POST["id"];
    $datetime = $_POST["datetime"];
    $latitude = $_POST["latitude"];
    $longitude = $_POST["longitude"];
    
    $sql = "update safety_incident set datetime = :datetime, latitude = :latitude, longitude = :longitude where id = :incident_id";
    
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
        
        <h1>Edit Safety Incident</h1>
        
        <form class="form form-horizontal" method="POST" action="edit.php">
          
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
                <input class="form-control" type="text" name="datetime" value="<?php echo($row["datetime"]); ?>">
              </div>
            </div>
            
            <div class="form-group">
              <label class="col-sm-2 control-label">Latitude</label>
              <div class="col-sm-4">
                <input class="form-control" type="text" name="latitude" value="<?php echo($row["latitude"]); ?>">
              </div>
            </div>
            
            <div class="form-group">
              <label class="col-sm-2 control-label">Longitude</label>
              <div class="col-sm-4">
                <input class="form-control" type="text" name="longitude" value="<?php echo($row["longitude"]); ?>">
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