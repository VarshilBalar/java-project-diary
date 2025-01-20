/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

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
public class fetchProjects extends HttpServlet {

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
        List<Map<String, String>> projects = new ArrayList<>();
        List<Map<String, String>> activityInfo = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow","admin","admin123");
            String sql = "SELECT * FROM projects";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, String> status = new HashMap<>();
                Map<String, String> project = new HashMap<>();
                project.put("project_id", rs.getString("project_id"));
                String sql1 = "SELECT COUNT(*) FROM activities where status=? and project_id=?";
                PreparedStatement pstmt1 = conn.prepareStatement(sql1);
                pstmt1.setString(1,"To Do");
                pstmt1.setString(2,rs.getString("project_id"));
                ResultSet rs1 = pstmt1.executeQuery();
                while (rs1.next()) {
                    status.put("toDo", rs1.getString(1));
//                    activityInfo.add(toDo);
                }

                String sql2 = "SELECT COUNT(*) FROM activities where status=? and project_id=?";
                PreparedStatement pstmt2 = conn.prepareStatement(sql2);
                pstmt2.setString(1,"In Progress");
                pstmt2.setString(2,rs.getString("project_id"));
                ResultSet rs2 = pstmt2.executeQuery();
                while (rs2.next()) {
                    status.put("inProgress", rs2.getString(1));
//                    activityInfo.add(inProgress);
                }
                String sql3 = "SELECT COUNT(*) FROM activities where status=? and project_id=?";
                PreparedStatement pstmt3 = conn.prepareStatement(sql3);
                pstmt3.setString(1,"completed");
                pstmt3.setString(2,rs.getString("project_id"));
                ResultSet rs3 = pstmt3.executeQuery();
                while (rs3.next()) {
                    status.put("completed", rs3.getString(1));
                }
                activityInfo.add(status);
                project.put("name", rs.getString("project_name"));
                project.put("obj", rs.getString("objectives"));
                project.put("crtd_by", rs.getString("created_by"));
                project.put("ddline", rs.getString("deadline"));
                project.put("start_time", rs.getString("start_time"));
                projects.add(project);
            }
            
            List<Map<String, String>> mergedList = new ArrayList<>();
            for (int i = 0; i < projects.size(); i++) {
                Map<String, String> mergedMap = new HashMap<>();
                mergedMap.putAll(projects.get(i));  // Add project details
                mergedMap.putAll(activityInfo.get(i)); // Add activity info
                mergedList.add(mergedMap);
            }
            session.setAttribute("projectList", mergedList);
            out.print("<script>window.location.href='projects.jsp';</script>");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
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
            Logger.getLogger(fetchProjects.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(fetchProjects.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(fetchProjects.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(fetchProjects.class.getName()).log(Level.SEVERE, null, ex);
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
