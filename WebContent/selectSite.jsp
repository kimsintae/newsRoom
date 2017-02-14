<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Untitled Document</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>   -->
    <style>
        .NAVER{
            background: #00c73c;
        }
        .CNN{
            background: #cb0000;
        }
        .NATE{
            background: #e82727;
        }
        .DAUM{
            background: #618ffc;
        }
        
    </style>
</head>
<body>
<div class="container mainBox">
    <div class="container col-sm-8">
      <h1 class="title">SITES</h1>
      <p class="title_sub">Please select the site you want</p> 
    </div>
    <div class="container col-sm-4 mainBox2">
        <div class="btn-group">
          <a href="main.jsp?site=naver" type="button" class="btn btn-info NAVER">NAVER</a>
          <a href="main.jsp?site=daum" type="button" class="btn btn-info DAUM">DAUM</a>
          <a href="main.jsp?site=nate" type="button" class="btn btn-info NATE">NATE</a>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">  

    
    
    
</script>
</body>
</html>