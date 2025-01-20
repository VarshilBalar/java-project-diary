<%@page import="jakarta.servlet.http.HttpServlet" %>
<%@page import="jakarta.servlet.http.HttpServletRequest" %>
<%@page import="jakarta.servlet.http.HttpServletResponse" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<% 
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String name = null;
    String obj = null;
    String ddline = null;
    String p_id = request.getParameter("projectID");
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow","admin","admin123");
    String sql = "SELECT * FROM projects where project_id = "+p_id;
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();
    while (rs.next()) {
        name = rs.getString("project_name");
        obj = rs.getString("objectives");
        ddline = rs.getString("deadline");
    }
    
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width" />
  <title>Your Projects</title>
  <style>
      body{
    margin:0;
    padding:0;
    height: 100vh;
    font-family: Arial, Helvetica, sans-serif;
    position: relative;
}
      .formSection {
    width: 100%;
    height: 100%;
    position: absolute;
    z-index: 2;
    display: none;
}

.form {
    width: 500px;
    height: 500px;
    margin: auto;
    background-color: white;
    border: 1px solid black;
    border-radius: 4px;
    padding: 10px;
}

.formTitle {
    font-size: 20px;
    font-weight: 700;
}


.projectNameField{
    display: flex;
    flex-direction: column;
    gap:5px;
    margin-top:20px;
}

.projectTeamMembers{
    margin-top:10px;
    display: flex;
    flex-direction: column;
    gap:5px;
}

.projectTeamMembersAddition{
    display: flex;
    align-items: end;
}
.projectTeamMembersButton {
    width: 90px;
    height: 30px;
}

.projectTeamTags{
    width: calc(100% - 270px);
    font-size:12px;
    padding:4px 8px;
    max-height: 80px;
    overflow-y: scroll;
}

.projectTeamTags::-webkit-scrollbar {
    scroll-behavior: smooth;
    width: 5px;
    background-color: #F5F5F5;
}

.projectTeamTags::-webkit-scrollbar-thumb {
    border-radius: 10px;
    -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
    background-color: #f3eded;
}

.projectTeamMemberDetails{
    /* width: calc(100% - 30px); */
    padding:1px;
    border-bottom:1px solid gray;
}

.projectDescription{
    display: flex;
    flex-direction: column;
    margin-top:10px;
}

.projectDeadline{
    display: flex;
    gap:5px;
    margin-top:10px;
}

.deadlineInputDiv{
    display: flex;
    gap:3px;
    font-size:13px;
}

.deadlineInput{
    width:100px;
}

.projectFormButtons{
    margin-top:40px;
}

.inputTitle{
    font-size:13px;
}

.inputField{
    width:80%;
    height: 20px;
}

.navbar{
    display: flex;
    justify-content: space-between;
    width:100%;
    height: 50px;
    align-items: center;
    border-bottom: 2px solid rgb(226, 221, 221);
}

.navLink{
    text-decoration: none;
}

.leftNavSection{
    display: flex;
    height: 100%;
    align-items: center;
}
  </style>
    </head>
    <body>
        <form class="form" action="updateProject">
            <div class="formTitle">Eidt Project</div>
            <div class="projectNameField">
              <label for="projectName" class="inputTitle">Project Name:</label>
              <input name="projectName" id="projectName" class="inputField projectName" type="text" value="<%= name%>" required>
            </div>
            <div class="projectTeamMembers">
              <div class="projectTeamMembersAddition">
                <div class="projectTeamMembersInput">
                  <label for="addTeam" class="inputTitle">Add Team Members</label>
                  <input name="addTeam" class="inputField teamMemberField" type="text">
                </div>
                <button class="projectTeamMembersButton">Add</button>
              </div>
              <div class="projectTeamTags">

              </div>
            </div>
            <div class="projectDescription">
              <label for="projectDesc" class="inputTitle">Description</label>
              <textarea name="projectDesc" id="projectDesc" rows="6" cols="10" required><%= obj%></textarea>
            </div>
            <div class="projectDeadline">
              <label for="projectDead" class="inputTitle">Deadline:</label>
              <input class="deadlineInput" name="deadline" id="deadline" type="date" value="<%= ddline%>"required>
            </div>
            <div class="projectFormButtons">
              <!--<button type="button" class="projectCancelButton">Cancel</button>-->
              <button class="projectCancelButton" onclick="goBackProject()">Cancel</button>
              <button type="submit" class="projectFormButton">
                  <% session.setAttribute("update_project_id", p_id); %>
                  Update

              </button>
            </div>
          </form>
    </body>
    <script>
        const projectCancelButton = document.querySelector('.projectCancelButton');
        projectCancelButton.addEventListener("click",function(event){ 
            event.preventDefault();
            const overlay = document.querySelector(".overlay");
            const form = document.querySelector('.formSection');
            overlay.style.display = "none";
            form.style.display = "none";
        })

        function goBackProject() {
            window.location.href = "fetchProjects";
        }
    </script>
</html>