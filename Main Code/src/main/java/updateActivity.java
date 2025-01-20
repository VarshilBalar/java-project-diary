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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author varsh
 */
public class updateActivity extends HttpServlet {

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
            int u_id = 0;
            HttpSession session = request.getSession();
            String p_id = (String) session.getAttribute("update_activity_id");
            
            String aname = request.getParameter("activityName");
            String atype = request.getParameter("activityType");
            String description = request.getParameter("activityDesc");
            String assigned_to = request.getParameter("addTeam");
            String ddline = request.getParameter("activityDdline");
            out.print(aname);
            out.print(atype);
            out.print(description);
            out.print(ddline);
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow","admin","admin123");
            String qry_temp = "SELECT userID FROM users WHERE email = ?";
            PreparedStatement pstmt = conn.prepareStatement(qry_temp);
            pstmt.setString(1, assigned_to); // Set the value of the parameter
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                u_id = rs.getInt(1);
            }
            String sql = "UPDATE activities SET activity_name = ?, activity_type = ?, assigned_user_id = ?,description = ?, deadline = ? WHERE activity_id = ?";

            PreparedStatement statement = conn.prepareStatement(sql);
            
            statement.setString(1, aname);
            statement.setString(2, atype);
            statement.setInt(3, u_id);
            statement.setString(4, description);
            statement.setString(5, ddline);
            statement.setString(6, p_id);
            
            statement.executeUpdate();
            out.print("<script>window.location.href=fetchProjects;</script>");
            RequestDispatcher rd = request.getRequestDispatcher("fetchProjects");
            rd.include(request, response);
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
            Logger.getLogger(updateActivity.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(updateActivity.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(updateActivity.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(updateActivity.class.getName()).log(Level.SEVERE, null, ex);
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
