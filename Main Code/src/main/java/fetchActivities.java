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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author varsh
 */
public class fetchActivities extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            List<Map<String, String>> activities = new ArrayList<>();
            List<Map<String, String>> users = new ArrayList<>();
            Set<String> uniqueUserIDs = new HashSet<>();
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String p_id = request.getParameter("projectID");
            HttpSession session = request.getSession();
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow", "admin", "admin123");
            String sql = "SELECT * FROM activities where project_id=? ORDER BY activity_type";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, p_id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, String> activity = new HashMap<>();
                activity.put("activity_id", rs.getString("activity_id"));
                activity.put("project_id", rs.getString("project_id"));
                activity.put("a_name", rs.getString("activity_name"));
                activity.put("a_type", rs.getString("activity_type"));
                activity.put("a_obj", rs.getString("description"));
                activity.put("assign_to", rs.getString("assigned_user_id"));
                activity.put("start_time", rs.getString("start_time"));
                activity.put("ddline", rs.getString("deadline"));
                activity.put("a_status", rs.getString("status"));
                activity.put("activity_id", rs.getString("activity_id"));
                activity.put("time_spent", rs.getString("time_spent"));
                activities.add(activity);
            }
            session.setAttribute("activityList", activities);
            session.setAttribute("project_id_for_activity", p_id);

            String sql2 = "Select assigned_user_id from activities where project_id=" + p_id;
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            ResultSet rs2 = pstmt2.executeQuery();
            while (rs2.next()) {
                String sql3 = "Select * from users where userID=" + rs2.getString("assigned_user_id");
                PreparedStatement pstmt3 = conn.prepareStatement(sql3);
                ResultSet rs3 = pstmt3.executeQuery();
                while (rs3.next()) {
                    String userID = rs3.getString("userID"); // Using userID as the unique identifier
                    if (!uniqueUserIDs.contains(userID)) {
                        Map<String, String> user = new HashMap<>();
                        user.put("userID", userID);
                        user.put("name", rs3.getString("name"));
                        user.put("email", rs3.getString("email"));
                        user.put("pn", rs3.getString("phone_number"));
                        user.put("pp", rs3.getString("profile_picture"));
                        users.add(user);
                        uniqueUserIDs.add(userID); // Mark this userID as processed
                    }
                }
            }
            session.setAttribute("usersList", users);

            RequestDispatcher rd = request.getRequestDispatcher("projectDetails.jsp");
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(fetchActivities.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(fetchActivities.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(fetchActivities.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(fetchActivities.class.getName()).log(Level.SEVERE, null, ex);
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
