<?php
  
  include "../database.php";
  
  $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
    
    $driver_id = $_POST["id"];
    $name = $_POST["name"];
    $hire_date = $_POST["hire_date"];
    
    $sql = "update driver set name = :name, hire_date = :hire_date where id = :driver_id";
   
    $stmt = $pdo->prepare($sql);
    $stmt->execute(array(":capacity"  => $capacity, 
                         ":name"      => $name, 
                         ":hire_date" => $hire_date));
    
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
        
        <h1>Edit Driver</h1>
        
        <form class="form form-horizontal" method="POST" action="edit.php">
          
            <?php
              
              $driver_id = $_GET["id"];
              
              $sql = "select id, name, hire_date from vehicle where id = :driver_id";
   
              $stmt = $pdo->prepare($sql);
              $stmt->execute(array(":driver_id" => $driver_id));
              
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
              <label class="col-sm-2 control-label">Hire Date</label>
              <div class="col-sm-4">
                <input class="form-control" type="text" name="hire_date" value="<?php echo($row["hire_date"]); ?>">
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