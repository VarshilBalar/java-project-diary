<%-- 
    Document   : editActivityPage
    Created on : 11 Jan 2025, 4:59:38 pm
    Author     : varsh
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    List<Map<String, String>> activities = (List<Map<String, String>>) session.getAttribute("activityListtoUpdate");
    String name = null;
    String obj = null;
    String ddline = null;
    String type = null;
    String p_id = null;
    String activity_id = null;
    String assigned_to = (String) session.getAttribute("user_id_for_edit_activity");
    if (activities != null && !activities.isEmpty()) {
        for (Map<String, String> activity : activities) {
            activity_id = activity.get("activity_id");
            p_id = activity.get("project_id");
            name = activity.get("a_name");
            type = activity.get("a_type");
            obj = activity.get("a_obj");
            ddline = activity.get("ddline");
    }
    }
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Projects</title>
            <style>
                body{
              margin:0;
              padding:0;
              height: 100vh;
              font-family: Arial, Helvetica, sans-serif;
              position: relative;
          }
          
          .activityForm {
            width: 500px;
            height: 500px;
            margin: auto;
            background-color: white;
            border: 1px solid black;
            border-radius: 4px;
            padding: 10px;
            margin-top:50px;
        }
          
                .formSection {
              width: 50%;
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
        <form class="activityForm" action="updateActivity">
            <div class="formTitle">Edit Activity</div>
            <div class="projectNameField">
                <label for="projectName" class="inputTitle">Activity Name:</label>
                <input name="activityName" id="activityName" class="inputField projectName" value="<%= name%>" type="text">
            </div>
            <div class="activityTypeField">
                <label for="activityType" class="inputTitle">Activity Type</label>
                <select name="activityType" class="activityTypeInput" id="activityType">
                    <option value="select" default><%= type%></option>
                    <option value="plan">Planning</option>
                    <option value="req">Requirement Analysis</option>
                    <option value="design">Design</option>
                    <option value="front">Frontend Development</option>
                    <option value="back">Backend Development</option>
                    <option value="api">API Development</option>
                    <option value="database">Database Management</option>
                    <option value="test">Testing (Unit, Integration, System)</option>
                    <option value="debug">Debugging</option>
                    <option value="deploy">Deployment</option>
                    <option value="code">Code Review</option>
                    <option value="docs">Documentation</option>
                    <option value="research">Research</option>
                    <option value="perform">Performance Optimization</option>
                    <option value="main">Maintenance</option>
                    <option value="sprint">Sprint Planning</option>
                    <option value="retro">Retrospective</option>
                    <option value="bug">Bug Fixing</option>
                    <option value="security">Security Assessment</option>
                    <option value="other">Other</option>
                </select>
            </div>
            <div class="projectTeamMembers">
                <div class="projectTeamMembersAddition">
                    <div class="projectTeamMembersInput">
                        <label for="addTeam" class="inputTitle">Assign To</label>
                        <input name="addTeam" id="addTeam" class="inputField teamMemberField" value="<%= assigned_to%>" type="text">
                    </div>
                    <button class="projectTeamMembersButton">Add</button>
                </div>
                <div class="projectTeamTags">

                </div>
            </div>
            <div class="projectDescription">
                <label for="projectDesc" class="inputTitle">Activity Objectives</label>
                <textarea name="activityDesc" id="activityDesc" rows="6" cols="10"><%= obj%></textarea>
            </div>
            <div class="projectDeadline">
                <label for="projectDead" class="inputTitle">Deadline:</label>
                <input class="deadlineInput" type="date" name="activityDdline" id="activityDdline" value="<%= ddline%>">
            </div>
            <div class="projectFormButtons">
                <button class="projectCancelButton" onclick="goBackProject()">Cancel</button>
                <button type="submit" class="projectCreateButton">
<% session.setAttribute("update_activity_id", activity_id); %>
                    Update</button>
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
