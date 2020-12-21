<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
    PostDao dao = new PostDao(ConnectionProvider.getConnection());
    List<Category> list = dao.getCategories();

    int postId = Integer.parseInt(request.getParameter("post_id"));

    Post post = dao.getPostById(postId);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= post.getPostTitle()%> || TechBlog</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <style>
            body {
                background: #006064;
            }
            .post-title {
                font-weight: 400;
                font-size: 30px;
                color: #006064;
            }
            .post-content {
                font-weight: 100;
                font-size: 25px;
            }
            .post-name-date {
                font-size: 14px;
            }

        </style>
        <script src="https://kit.fontawesome.com/b175d26c91.js" crossorigin="anonymous"></script>


    </head>
    <body>

        <!-- Navbar -->

        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="#">Navbar</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Link</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Dropdown
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Action</a>
                            <a class="dropdown-item" href="#">Another action</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                    </li>

                    <!-- Button trigger modal -->
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#postModal">Link</a>
                    </li>
                </ul>

                <ul class="navbar-nav mr-right">

                    <!-- Button trigger modal -->

                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#profileModal"><%= user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout">Logout</a>
                    </li>
                </ul>

            </div>
        </nav>

        <!-- Navbar end -->


        <%
            Message message = (Message) session.getAttribute("message");

            if (message != null) {

        %>

        <div class="alert <%= message.getCssClass()%>">
            <%= message.getContent()%>
        </div>

        <%

            }
            session.removeAttribute("message");

        %>


        <div class="container-fluid">

            <div class="row my-4">

                <div class="col-md-6 offset-md-3">

                    <div class="card">

                        <div class="card-header">
                            <h4 class="post-title"><%= post.getPostTitle()%></h4>

                        </div>

                        <div class="card-body">
                            <img class="card-img-top" src="blog_pics/<%= post.getPostPic()%>" style="width: 100%; height: 40vh">
                            
                            <div class="row mt-2 post-name-date">
                                
                                <div class="col-md-8">
                                    <%  
                                        UserDao userDao = new UserDao(ConnectionProvider.getConnection());
                                        
                                        
                                    %>
                                    
                                    <p><a href="#"><%= userDao.getUserById(post.getUserId()).getName() %></a> has posted:</p>
                                </div>
                                
                                <div class="col-md-4">
                                    <p><b><i><%= DateFormat.getDateTimeInstance().format(post.getPostDate()) %></i></b></p>
                                </div>
                                
                            </div>
                            
                            
                            <p class="post-content"><%= post.getPostContent()%></p>
                            <br>
                            <div class="post-code">
                                <pre><%= post.getPostCode()%></pre>
                            </div>
                        </div>

                        <div class="card-footer">

                            <a class="btn btn-outline-primary"><i class="fa fa-thumbs-up"></i><span>10</span></a>
                            <a class="btn btn-outline-primary"><i class="fa fa-comment"></i><span>20</span></a>

                        </div>

                    </div>

                </div>

            </div>

        </div>

        <!-- Profile Modal -->

        <div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img class="img-fluid" src="pics/<%= user.getProfile()%>" style="max-width: 120px; border-radius: 50%;"> 
                            <h5 class="mt-3"><%= user.getName()%></h5>

                            <div id="profile-details">
                                <table class="table">

                                    <tbody>

                                        <tr>
                                            <th scope="row">Id:</th>
                                            <td><%= user.getId()%></td>

                                        </tr>

                                        <tr>
                                            <th scope="row">Email:</th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>

                                        <tr>
                                            <th scope="row">Gender:</th>
                                            <td><%= user.getGender()%></td>

                                        </tr>

                                        <tr>
                                            <th scope="row">Registered On:</th>
                                            <td><%= user.getDateTime()%></td>
                                        </tr>

                                    </tbody>

                                </table>

                            </div>

                        </div>

                        <!--Profile edit-->

                        <div id="profile-edit" class="text-center" style="display: none">

                            <h4 class="mt-2">Please Edit Carefully</h4>

                            <form action="edit" class="mt-2" method="POST" enctype="multipart/form-data">

                                <table class="table">

                                    <tr>
                                        <td>Id:</td>
                                        <td><%= user.getId()%></td>
                                    </tr>

                                    <tr>
                                        <td>Email:</td>
                                        <td><input type="email" class="form-control" name="email" value="<%= user.getEmail()%>" ></td>
                                    </tr>

                                    <tr>
                                        <td>Name:</td>
                                        <td><input type="text" class="form-control" name="name" value="<%= user.getName()%>" ></td>
                                    </tr>

                                    <tr>
                                        <td>Password:</td>
                                        <td><input type="password" class="form-control" name="password" value="<%= user.getPassword()%>" ></td>
                                    </tr>

                                    <tr>
                                        <td>Gender:</td>
                                        <td><%= user.getGender()%> </td>
                                    </tr>

                                    <tr>
                                        <td>Profile Pic:</td>
                                        <td><input type="file" name="image" class="form-control"></td>
                                    </tr>

                                </table>

                                <div class="container" >

                                    <button type="submit" class="btn btn-custom-primary text-white"> Save </button>

                                </div>

                            </form>

                        </div>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Profile Modal end --> 

        <!--Post Modal-->

        <div class="modal fade" id="postModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide Post Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <form id="post-form" action="post" method="POST">

                        <div class="modal-body">



                            <div class="form-group">

                                <select class="form-control" name="catId">

                                    <option selected disabled>Select Category</option>

                                    <%
                                        for (Category c : list) {
                                    %>

                                    <option value="<%= c.getCatId()%>"><%= c.getCatName()%></option>

                                    <%
                                        }

                                    %>

                                </select>

                            </div>

                            <div class="form-group">

                                <input name="postTitle" type="text" placeholder="Enter post title" class="form-control">

                            </div>

                            <div class="form-group">

                                <textarea name="postContent" rows="4" type="text" placeholder="Enter post content" class="form-control"></textarea>

                            </div>

                            <div class="form-group">

                                <textarea name="postCode" rows="4" type="text" placeholder="Enter Code (If any)" class="form-control"></textarea>

                            </div>

                            <div class="form-group">
                                <label>Select your image</label><br>
                                <input name="postImage" type="file">
                            </div>




                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-custom-primary text-white">Post</button>
                        </div>
                    </form>           
                </div>
            </div>
        </div>

        <!--Post Modal End-->



        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
        <script>

            $(document).ready(function () {

                let editStatus = false;

                $('#edit-profile-btn').click(function () {

                    if (editStatus == false) {

                        $('#profile-details').hide()
                        $('#profile-edit').show()
                        $(this).text("Back")

                    } else {

                        $('#profile-details').show()
                        $('#profile-edit').hide()

                        $(this).text("Edit")

                    }
                    editStatus = !editStatus;

                })
            })

        </script>

        <script>

            $(document).ready(function () {

                $('#post-form').on('submit', function (evt) {

                    console.log("Clicked");

                    evt.preventDefault();

                    let form = new FormData(this)

                    $.ajax({
                        url: "post",
                        type: "POST",
                        data: form,

                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                        },

                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR);
                        },

                        processData: false,
                        contentType: false

                    })

                })

            })

        </script>


    </body>
</html>
