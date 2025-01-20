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
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author varsh
 */
public class fetchIndividualActivity extends HttpServlet {

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
            List<Map<String, String>> challenges = new ArrayList<>();
            List<Map<String, String>> solutions = new ArrayList<>();
            String user_id_for_individual_activity = null;
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String assigned_user_name = null;
            String p_id = request.getParameter("ActivityID");
            HttpSession session = request.getSession();
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow","admin","admin123");
            String sql = "SELECT * FROM activities where activity_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(p_id));
            rs = pstmt.executeQuery();
            while(rs.next()) {
                Map<String, String> activity = new HashMap<>();
                activity.put("activity_id", rs.getString("activity_id"));
                activity.put("project_id", rs.getString("project_id"));
                activity.put("a_name", rs.getString("activity_name"));
                activity.put("a_type", rs.getString("activity_type"));
                activity.put("a_obj", rs.getString("description"));
                assigned_user_name = rs.getString("assigned_user_id");
                activity.put("start_time", rs.getString("start_time"));
                activity.put("ddline", rs.getString("deadline"));
                activity.put("a_status", rs.getString("status"));
                activity.put("activity_id", rs.getString("activity_id"));
                activity.put("time_spent", rs.getString("time_spent"));
                activities.add(activity);
            }
            
            String sql_new = "SELECT * FROM challenges where activity_id=?";
            PreparedStatement pstmt_new = conn.prepareStatement(sql_new);
            pstmt_new.setInt(1, Integer.parseInt(p_id));
            ResultSet rs_new = pstmt_new.executeQuery();
            while(rs_new.next()) {
                Map<String, String> chlg = new HashMap<>();
                chlg.put("a_id", rs_new.getString("activity_id"));
                chlg.put("ch_id", rs_new.getString("challenge_id"));
                chlg.put("chlg", rs_new.getString("challenge"));
                chlg.put("owner", rs_new.getString("challenged_by"));
                challenges.add(chlg);
            }
            
            session.setAttribute("chlgs", challenges);
            
            String sql_new1 = "SELECT * FROM solutions where activity_id=?";
            PreparedStatement pstmt_new1 = conn.prepareStatement(sql_new1);
            pstmt_new1.setInt(1, Integer.parseInt(p_id));
            ResultSet rs_new1 = pstmt_new1.executeQuery();
            while(rs_new1.next()) {
                Map<String, String> sol = new HashMap<>();
                sol.put("a_id", rs_new1.getString("activity_id"));
                sol.put("ch_id", rs_new1.getString("challenge_id"));
                sol.put("sol_id", rs_new1.getString("solution_id"));
                sol.put("sol", rs_new1.getString("solution"));
                sol.put("owner", rs_new1.getString("solved_by"));
                solutions.add(sol);
            }
            
            session.setAttribute("sol", solutions);
            
            String sql2 = "SELECT email FROM users where userID="+assigned_user_name;
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            ResultSet rs2 = pstmt2.executeQuery();
            while (rs2.next()) {
                user_id_for_individual_activity = rs2.getString(1);
            }
            session.setAttribute("individualActivity", activities);
            session.setAttribute("user_id_for_individual_activity", user_id_for_individual_activity);
            conn.close();
            out.print("<script>window.location.href='activityDetails.jsp';</script>");
            RequestDispatcher rd = request.getRequestDispatcher("activityDetails.jsp");
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
            Logger.getLogger(fetchIndividualActivity.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(fetchIndividualActivity.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(fetchIndividualActivity.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(fetchIndividualActivity.class.getName()).log(Level.SEVERE, null, ex);
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
