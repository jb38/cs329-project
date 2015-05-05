<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Transportation Website | CS329 Database Project</title>
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.css">  
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
      
      <h4>Actions</h4>
      <ul class="list-unstyled">
        <li><a href="actions/assign_vehicle.php">Assign Vehicle to Driver</li>
        <li><a href="actions/safety_incident.php">Log Safety Incident</li>
        <!-- TODO add the rest of the action links here -->
      </ul>
      
      <h4>Reports</h4>
      <ul class="list-unstyled">
        <li><a href="reports/safety.php">Safety Records</li>
        <!-- TODO add the rest of the report links here -->
      </ul>
      
      <h4>Table Management</h4>
      <ul class="list-unstyled">
        <li><a href="drivers">Manage Drivers</li>
        <li><a href="vehicles">Manage Vehicles</li>
        <li><a href="safety_incidents">Manage Safety Incidents</li>
        <!-- TODO add the rest of the entity/relation links here -->
        <li><a href="stops">Manage Stops</li>
        <li><a href="lines">Manage Lines</li>
        <li><a href="line_stops">Manage Line Stops</li>
        <li><a href="riders">Manage Riders</li>
        <li><a href="trips">Manage Trips</li>
      </ul>
      
    </div>
    
    <script src="vendor/jquery/jquery.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.js"></script>
    
  </body>
</html> 