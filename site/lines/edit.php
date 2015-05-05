<?php
  
  include "../database.php";
  
  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
    
    $line_id = $_POST["id"];
    $name = $_POST["name"];
    $vehicle_type = $_POST["vehicle_type"];
    
    $sql = "update line set name = :name, vehicle_type = :vehicle_type where id = :line_id";
   
    $stmt = $pdo->prepare($sql);
    $stmt->execute(array(":name"      => $name, 
                         ":vehicle_type" => $vehicle_type,
                         ":line_id" => $line_id));
    
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
        
        <h1>Edit Line</h1>
        
        <form class="form form-horizontal" method="POST" action="edit.php">
          
            <?php
              
              $line_id = $_GET["id"];
              
              $sql = "select id, name, vehicle_type from line where id = :line_id";
   
              $stmt = $pdo->prepare($sql);
              $stmt->execute(array(":line_id" => $line_id));
              
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
              <label class="col-sm-2 control-label">Name</label>
              <div class="col-sm-4">
                <input class="form-control" type="text" name="name" value="<?php echo($row["name"]); ?>">
              </div>
            </div>
            
			<div class="form-group">
              <label class="col-sm-2 control-label">Vehicle Type</label>
              <div class="col-sm-4">
                <input class="form-control" type="text" name="vehicle_type" value="<?php echo($row["vehicle_type"]); ?>">
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