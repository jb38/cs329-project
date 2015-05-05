<?php
  include '../database.php';
  
  if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    $vehicle_id = $_POST["id"];
    
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);

    $sql = "delete from vehicle where id = :vehicle_id";

    $stmt = $conn->prepare($sql);
    $stmt->bindParam(":vehicle_id", $vehicle_id, PDO::PARAM_INT);

    $row = $stmt->execute();
    
    header( "Location: index.php" );
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
      
      <h1>Delete Vehicle</h1>
      
      <form class="form form-horizontal" method="POST" action="delete.php">
        
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
            <label class="col-sm-2 control-label">ID</label>
            <div class="col-sm-4">
              <p class="form-control-static"><?php echo($row[0]); ?></p>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Capacity</label>
            <div class="col-sm-4">
              <p class="form-control-static"><?php echo($row[1]); ?></p>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label">Type</label>
            <div class="col-sm-4">
              <p class="form-control-static"><?php echo($row[3]); ?></p>
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
    
    <script src="../vendor/jquery/jquery.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.js"></script>
    
  </body>
</html> 