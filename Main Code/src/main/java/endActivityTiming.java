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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author varsh
 */
public class endActivityTiming extends HttpServlet {

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
            HttpSession session = request.getSession();
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow","admin","admin123");
            String a_id_temp = request.getParameter("activity_id");
            int a_id = Integer.parseInt(a_id_temp);
            String start_time = null;
            String sql_temp = "Select start_time from activities where activity_id=?";
            PreparedStatement ptstt = conn.prepareStatement(sql_temp);
            ptstt.setInt(1, a_id);
            ResultSet rs_temp = ptstt.executeQuery();
            while (rs_temp.next()) {
                start_time = rs_temp.getString("start_time");
            }
            if (start_time != null) {
                start_time = "2025-01-12 00:28:13";
            }
            LocalDateTime currentTime = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime storedDateTime = LocalDateTime.parse(start_time, formatter);

            long days = ChronoUnit.DAYS.between(storedDateTime, currentTime);
            long hours = ChronoUnit.HOURS.between(storedDateTime, currentTime) % 24;
            long minutes = ChronoUnit.MINUTES.between(storedDateTime, currentTime) % 60;

            String result = String.format("%02dd %02dh %02dm", Math.abs(days), Math.abs(hours), Math.abs(minutes));
            
            String sql = "update activities set  status= ?, time_spent=? where activity_id=?";
            PreparedStatement ptst = conn.prepareStatement(sql);
            ptst.setString(1, "completed");
            ptst.setString(2, result);
            ptst.setInt(3, a_id);
            ptst.executeUpdate();
            conn.close();
            String user_email = (String) session.getAttribute("email_op");
            out.print("<script>window.location.href='fetchActivitiesForUser?userID=" + user_email + "';</script>");
            RequestDispatcher rd = request.getRequestDispatcher("fetchActivitiesForUser");
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(endActivityTiming.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(endActivityTiming.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(endActivityTiming.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(endActivityTiming.class.getName()).log(Level.SEVERE, null, ex);
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
