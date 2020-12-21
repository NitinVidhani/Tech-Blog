<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>

        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="https://kit.fontawesome.com/b175d26c91.js" crossorigin="anonymous"></script>
    </head>
    <body class="primary-background">
        <%@include file="navbar.jsp" %>

        <main>

            <div class="container">

                <div class="col-md-6 offset-md-3">

                    <div class="card">

                        <div class="card-header text-center">
                            <span class="fa fa-3x fa-user-circle"></span>
                            <br>
                            Register
                        </div>

                        <div class="card-body">

                            <form id="reg-form" action="register" method="POST">

                                <div class="form-group">
                                    <label for="user_name">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp">
                                </div>

                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>


                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="password" type="password" class="form-control" id="exampleInputPassword1">
                                </div>


                                <div class="form-group form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree terms and conditions</label>
                                </div>

                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <input type="radio" name="gender" value="Male">Male
                                    <input type="radio" name="gender" value="Female">Female
                                </div>

                                <button type="submit" class="btn btn-primary">Submit</button>

                            </form>

                        </div>

                        <div class="card-footer">
                            <div id="alert-success" class="alert alert-success alert-dismissible fade show" role="alert">
                                User successfully registered
                            </div>
                            <div id="alert-warning" class="alert alert-warning alert-dismissible fade show" role="alert">
                                Box not checked
                            </div>
                            <div id="alert-danger" class="alert alert-danger alert-dismissible fade show" role="alert">
                                An unknown error occured
                            </div>
                        </div>

                    </div>

                </div>

            </div>

        </main>

        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
        <script src="js/script.js" type="text/javascript"></script>
        <script>

            $(document).ready(function () {

                console.log("Loaded")

                $('#alert-success').hide();
                $('#alert-danger').hide();
                $('#alert-warning').hide();

                $('#reg-form').on('submit', function (event) {

                    event.preventDefault();

                    let form = new FormData(this);

                    $.ajax({

                        url: "register",
                        type: "POST",
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data)
                            
                            if (data.trim() === 'done') {
                                $('#alert-danger').hide();
                                $('#alert-warning').hide();
                                $('#alert-success').show();
                                console.log("success")
                                setTimeout(function() {
                                    window.location = "login_page.jsp";
                                }, 1000)
                            } else {
                                $('#alert-warning').show();
                                $('#alert-success').hide();
                                $('#alert-danger').hide();
                                
                            }


                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR)
                            console.log("error")
                            $('#alert-danger').show();
                            $('#alert-warning').hide();
                            $('#alert-success').hide();
                        },
                        processData: false,
                        contentType: false

                    })

                })

            })

        </script>
    </body>
</html>
