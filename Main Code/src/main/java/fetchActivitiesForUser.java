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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author varsh
 */
public class fetchActivitiesForUser extends HttpServlet {

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
            List<Map<String, String>> activities = new ArrayList<>();
            int u_id = 0;
            Connection conn = null;
            String email = request.getParameter("userID");
            HttpSession session = request.getSession();
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow","admin","admin123");
            String sql = "SELECT userID FROM USERS WHERE email=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                u_id = rs.getInt(1);
            }
            String sql1 = "SELECT * FROM activities where assigned_user_id=? and status != ? ORDER BY activity_type" ;
            PreparedStatement pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setInt(1, u_id);
            pstmt1.setString(2, "completed");
            ResultSet rs1 = pstmt1.executeQuery();
            while (rs1.next()) {
                Map<String, String> activity = new HashMap<>();
                activity.put("activity_id", rs1.getString("activity_id"));
                activity.put("project_id", rs1.getString("project_id"));
                activity.put("a_name", rs1.getString("activity_name"));
                activity.put("a_type", rs1.getString("activity_type"));
                activity.put("a_obj", rs1.getString("description"));
                activity.put("assign_to", rs1.getString("assigned_user_id"));
                if(rs1.getString("start_time") == null ) {
                    activity.put("time_spent", "Activity not started");
                } else {
                    LocalDateTime currentTime = LocalDateTime.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                LocalDateTime storedDateTime = LocalDateTime.parse(rs1.getString("start_time"), formatter);

                long days = ChronoUnit.DAYS.between(storedDateTime, currentTime);
                long hours = ChronoUnit.HOURS.between(storedDateTime, currentTime) % 24;
                long minutes = ChronoUnit.MINUTES.between(storedDateTime, currentTime) % 60;

                String result = String.format("%02dd %02dh %02dm", Math.abs(days), Math.abs(hours), Math.abs(minutes));
                    activity.put("time_spent", result);
                }
                activity.put("start_time", rs1.getString("start_time"));
                activity.put("ddline", rs1.getString("deadline"));
                activity.put("a_status", rs1.getString("status"));
                activity.put("activity_id", rs1.getString("activity_id"));
                activities.add(activity);
            }
            conn.close();
            session.setAttribute("individualActivityForUser", activities);
//            out.print(activities);
            RequestDispatcher rd = request.getRequestDispatcher("myactivities.jsp");
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
            Logger.getLogger(fetchActivitiesForUser.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(fetchActivitiesForUser.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(fetchActivitiesForUser.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(fetchActivitiesForUser.class.getName()).log(Level.SEVERE, null, ex);
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
