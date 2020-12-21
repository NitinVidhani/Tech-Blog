<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">
    <%
        PostDao postDao = new PostDao(ConnectionProvider.getConnection());
        List<Post> list = null;
        int cid = Integer.parseInt(request.getParameter("cid"));
        if (cid == 0) {
            list = postDao.getAllPosts();
        } else {
            list = postDao.getPostByCatId(cid);
        }

        if (list.size() == 0) {
            out.println("<h3 class='display-3 text-center'>No posts in this category</h3>");
        }

        for (Post p : list) {
    %>

    <div class="col-md-6 mt-2">

        <div class="card">

            <img class="card-img-top" src="blog_pics/<%= p.getPostPic()%>">
            <div class="card-body">

                <b><%= p.getPostTitle()%></b>
                <p><%= p.getPostContent()%></p>

                <div class="card-footer bg-light">

                    <a href="#" class="btn btn-sm btn-outline-primary"><i class="far fa-thumbs-up"></i><span>10</span></a>
                    <a href="#" class="btn btn-sm btn-outline-primary"><i class="far fa-comment"></i><span>20</span></a>

                    <span class="text-right">
                        <a href="blog.jsp?post_id=<%= p.getPostId() %>" class="btn btn-sm btn-primary">Read More...</a>
                    </span>
                </div>
            </div>

        </div>

    </div>

    <%
        }
    %>
</div>