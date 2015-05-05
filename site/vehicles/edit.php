<?php
  include '../database.php';
  
  if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    $vehicle_id = $_POST["id"];
    $capcity = $_POST["capacity"];
    $type = $_POST["type"];
    
    
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
      <div class="col-sm-12">
        
        <h1>Edit Vehicle</h1>
        
        <form class="form form-horizontal" method="POST" action="edit.php">
          
            <?php
              
              $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
              
              $sql = "select v.id, v.capacity, v.type, t.description from vehicle v, vehicle_type t where v.type = t.id and v.id = ?";
   
              $stmt = $pdo->query($sql);
              $stmt->bindParam(1, $_GET["id"], PDO::PARAM_INT);
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
                <input class="form-control" name="capacity" value="<?php echo($row[1]); ?>">
              </div>
            </div>
            
            <!-- TODO convert this to a select -->
            <div class="form-group">
              <label class="col-sm-2 control-label">Type</label>
              <div class="col-sm-4">
                <input class="form-control" name="type" value="<?php echo($row[2]); ?>">
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