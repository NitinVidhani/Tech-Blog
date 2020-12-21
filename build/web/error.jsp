<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry! Something went wrong</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <style>
            img {
                width: 25vw;
            }
        </style>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container text-center">
            <img src="img/error.png" class="img-fluid"><br><br>
            <h3 class="display-3">
                Sorry! Something went wrong...
            </h3>
            <%= exception %>
            <a href="index.jsp" class="btn btn-lg text-white btn-custom-primary mt-3">Home</a>
        </div>
    </body>
</html>
