/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.ConnectException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author HP
 */
@MultipartConfig
public class EditServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

//            Fetch all data
            String email = request.getParameter("email");
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

//            Get user from session
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("currentUser");

            String oldFile = currentUser.getProfile();
            
//            Change details
            currentUser.setEmail(email);
            currentUser.setName(name);
            currentUser.setPassword(password);
            currentUser.setProfile(imageName);

//            Update Database
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            boolean updated = dao.updateUser(currentUser);

            if (updated) {

                String path = request.getRealPath("/") + "pics" + File.separator + currentUser.getProfile();

                String oldPath = request.getRealPath("/") + "pics" + File.separator + oldFile;
                
                if(!oldFile.equals("default.png")) {
                    Helper.deleteFile(oldPath);
                }
                
                if (Helper.saveFile(part.getInputStream(), path)) {

                    out.println("Updated");
                    Message message = new Message("Updated Successfully", "success", "alert-success");
                    session.setAttribute("message", message);

                }

            } else {
                out.println("Error");
                Message message = new Message("Something went wrong", "error", "alert-danger");
                session.setAttribute("message", message);

            }
            
            response.sendRedirect("profile.jsp");

            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
