/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author varsh
 */
public class createActivity extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String p_id_temp = (String) session.getAttribute("projectID");
            int p_id = Integer.valueOf(p_id_temp);
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow","admin","admin123");
            int u_id = 0;
            String aname = request.getParameter("activityName");
            String type = request.getParameter("activityType");
            String assigned_to_user = request.getParameter("addTeam");
            String description = request.getParameter("activityDesc");
            String ddline = request.getParameter("activityDdline");
            String crtd_by = (String) session.getAttribute("email_op");
            
            String qry_temp = "SELECT userID FROM users WHERE email = ?";
            PreparedStatement pstmt = conn.prepareStatement(qry_temp);
            pstmt.setString(1, assigned_to_user); // Set the value of the parameter
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                u_id = rs.getInt(1);
            }
            String[] teamMembersArray = request.getParameterValues("teamMembers");
//            List<String> teamMembers = Arrays.asList(teamMembersArray);
            String qry = "INSERT into ACTIVITIES(project_id, activity_name, activity_type, description, assigned_user_id, deadline, status) VALUES (?,?,?,?,?,?,?)";
                PreparedStatement ps = conn.prepareStatement(qry);
                ps.setInt(1, p_id);
                ps.setString(2, aname);
                ps.setString(3, type);
                ps.setString(4, description);
                ps.setInt(5, u_id);
                ps.setString(6, ddline);
                ps.setString(7, "To Do");
                ps.executeUpdate();
                out.print("<script>alert('New Activity created successfully');window.location.href='fetchProjects';</script>");
                RequestDispatcher rd = request.getRequestDispatcher("fetchProjects");
                rd.include(request, response); 
             conn.close();
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(createActivity.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(createActivity.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(createActivity.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(createActivity.class.getName()).log(Level.SEVERE, null, ex);
        }
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
