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
      
      <form class="form" method="POST" action="edit.php">
        
          <?php
            
            $conn = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
            
            $vehicle_id = $_GET["id"];
            
            $sql = "select v.id, v.capacity, v.type, t.description from vehicle v, vehicle_type t where v.type = t.id and v.id = " . $vehicle_id;
 
            $stmt = $conn->query($sql);
            $stmt->setFetchMode(PDO::FETCH_NUM);

            $row = $stmt->fetch();
          ?>
          	
          <input type="hidden" name="id" value="<?php echo($row[0]); ?>">
          
          <div class="form-group">
            <label>ID</label>
            <p class="form-control-static"><?php echo($row[0]); ?></p>
          </div>
          
          <div class="form-group">
            <label>Capacity</label>
            <input class="form-control" name="capacity" value="<?php echo($row[1]); ?>">
          </div>
          
          <!-- TODO convert this to a select -->
          <div class="form-group">
            <label>Type</label>
            <input class="form-control" name="type" value="<?php echo($row[2]); ?>">
          </div>
          
          <div class="form-group text-right">
            <button class="btn btn-primary">Apply</button>
            <a class="btn btn-link" href="index.php">Cancel</a>
          </div>	
      </form>
    </div>
    
    <script src="../vendor/jquery/jquery.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.js"></script>
    
  </body>
</html> 