<%-- 
    Document   : projectDetails
    Created on : 9 Jan 2025, 12:42:28 pm
    Author     : varsh
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page import="java.util.*" %>
<%
    String p_id = (String) session.getAttribute("project_id_for_activity");
    List<Map<String, String>> activities = (List<Map<String, String>>) session.getAttribute("activityList");
    List<Map<String, String>> users = (List<Map<String, String>>) session.getAttribute("usersList");

    session.setAttribute("projectID", p_id);
    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt2 = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    String email = null;
    String project_owner = null;
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow", "admin", "admin123");
    String sql2 = "SELECT created_by FROM projects where project_id = " + p_id;
    pstmt2 = conn.prepareStatement(sql2);
    rs2 = pstmt2.executeQuery();
    while (rs2.next()) {
        project_owner = rs2.getString(1);
    }
%>
<!Doctype html>
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
            a {
                display: block;
                text-decoration: none;
                color: black;
            }
            .overlay {
                width: 100%;
                height: 100%;
                background-color: black;
                opacity: 0.6;
                z-index: 1;
                position: absolute;
                display: none;
            }

            .formSection {
                width: 100%;
                height: 100%;
                position: absolute;
                z-index: 2;
                display: none;
            }

            .activityForm {
                display: none;
                width: 500px;
                height: 500px;
                margin: auto;
                background-color: white;
                border: 1px solid black;
                border-radius: 4px;
                padding: 10px;
                margin-top:50px;
            }

            .addMemberForm{
                display: none;
                width: 400px;
                min-height: 200px;
                margin: auto;
                background-color: white;
                border: 1px solid black;
                border-radius: 4px;
                padding: 10px;
                margin-top:50px;
            }

            .formTitle {
                font-size: 20px;
                font-weight: 700;
            }

            .projectNameField {
                display: flex;
                flex-direction: column;
                gap: 5px;
                margin-top: 20px;
            }

            .activityTypeField{
                display: flex;
                flex-direction: column;
                margin-top:10px;
                gap:5px;
            }

            .activityTypeInput{
                width:80%;
                height: 28px;
            }

            .projectTeamMembers {
                margin-top: 10px;
                display: flex;
                flex-direction: column;
            }

            .projectTeamMembersAddition{
                display: flex;
                align-items: end;
            }

            .projectTeamMembersButton {
                width: 90px;
                height: 30px;
            }

            .projectTeamMembersButton2 {
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

            .projectTeamTags2::-webkit-scrollbar {
                scroll-behavior: smooth;
                width: 5px;
                background-color: #F5F5F5;
            }

            .projectTeamTags2::-webkit-scrollbar-thumb {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
                background-color: #f3eded;
            }

            .projectTeamTags2{
                width: calc(100% - 270px);
                font-size:12px;
                padding:4px 8px;
                max-height: 80px;
                overflow-y: scroll;
            }

            .projectTeamTags2::-webkit-scrollbar {
                scroll-behavior: smooth;
                width: 5px;
                background-color: #F5F5F5;
            }

            .projectTeamTags2::-webkit-scrollbar-thumb {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
                background-color: #f3eded;
            }



            .projectTeamMemberDetails{
                /* width: calc(100% - 30px); */
                padding:1px;
                border-bottom:1px solid gray;
            }

            .projectDescription {
                display: flex;
                flex-direction: column;
                margin-top: 10px;
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

            .projectFormButtons {
                display: flex;
                gap:15px;
                justify-content: end;
                margin-top: 40px;
            }

            .projectFormButtons button{
                width:100px;
                height: 30px;
                background-color: white;
                font-weight: 700;
                border:1px solid black;
                cursor: pointer;
            }

            .inputTitle {
                font-size: 13px;
            }

            .inputField {
                width: 80%;
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

            .leftNavSection{
                display: flex;
                height: 100%;
                align-items: center;
            }

            .logoSection{
                display: flex;
                gap:10px;
            }

            .logo{
                width:32px;
                height: 32px;
            }

            .logoText{
                font-size:23px;
                color: #809bce;
                font-weight: 700;
            }

            .navs{
                display: flex;
                gap:15px;
                margin-left:70px;
                height: 100%;
                align-items: center;
                font-size: 14px;
            }

            .navLink{
                text-decoration: none;
            }

            .selectedNav{
                display: flex;
                height: 100%;
                border-bottom: 3.5px solid #2c4778;
                align-items: center;
            }

            .selectedNavText{
                color: #2c4778;
                font-weight: 600;
            }

            .unselectedNav{
                color:#354e7e;
            }

            .reportsButton{
                margin-left: 60px;
                border: none;
                width: 100px;
                height: 30px;
                color: #354e7e;
            }

            .rightNavSection {
                display: flex;
                height: 100%;
                align-items: center;
                margin-right: 12px;
                gap:12px;
            }

            .navImg{
                width:20px;
                height: 20px;
            }

            .navImg{
                width:20px;
                height: 20px;
            }

            .searchBox{
                height: 25px;
                border: 1px solid gray;
                border-radius: 4px;
            }

            .mainContent{
                display: flex;
                height: calc(100% - 52px);
                justify-content: space-between;
            }

            .sidebar{
                display: flex;
                flex-direction:column;
                width:200px;
                gap:10px;
                padding-top:25px;
                border-right: 2px solid rgb(226, 221, 221);
            }

            .sidebarLink{
                text-decoration: none;
            }

            .sidebarOptions{
                display: flex;
                padding: 5px 14px;
                gap:15px;
                cursor:pointer;
            }

            .sidebarOptions:hover{
                background-color: rgb(244, 243, 243);
            }

            .sidebarOptionActive{
                background-color: rgb(244, 243, 243);
            }

            .sidebarOptionsIcon{
                width:20px;
                height:20px;
            }

            .sidebarOptionsText{
                font-size:13px;
                color: rgb(102, 101, 101);
            }

            .mainContainer{
                width: calc(100% - 400px);
                overflow-y: scroll;
            }

            .mainContainer::-webkit-scrollbar{
                scroll-behavior: smooth;
                width: 5px;
                background-color: #F5F5F5;
            }

            .mainContainer::-webkit-scrollbar-thumb {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
                background-color: #f3eded;
            }

            .mainSection{
                margin:20px 20px;
            }

            .projectHeader{
                display: flex;
                gap:10px;
                border-bottom: 1px solid gray;
            }

            .projectIcon{
                width:50px;
                height: 50px;
            }

            .projectOptions{
                display: flex;
                flex-direction: column;
                gap:5px;
            }

            .projectTitle{
                font-size:20px;
                font-weight: 700;
                color:#2c4778;
            }

            .projectNav{
                display: flex;
                gap:12px;
                font-size:14px;
            }

            .navOption{
                padding-bottom:5px;
                cursor: pointer;
            }

            .activeOption{
                border-bottom: 2px solid black;
            }

            .createActivity{
                margin-top:15px;
                display: flex;
                justify-content: flex-end;
                margin-bottom:20px;
            }

            .exportButton {
                margin-right: 15px;
                height: 30px;
                background-color: white;
                color: black;
                cursor:pointer;
                border:2px solid gray;
                border-radius: 4px;
                font-weight: 700;
            }
            .createActivityButton{
                height: 30px;
                background-color: white;
                color: black;
                cursor:pointer;
                border:2px solid gray;
                border-radius: 4px;
                font-weight: 700;
            }

            .activityTypeSection{
                margin-top: 20px;
            }

            .activityHeaderBar{
                display: flex;
                justify-content: space-between;
                margin:0 40px;
                font-size:12px;
                color:gray;
                margin-bottom:20px;
            }

            .activityHeaderGroup{
                display: flex;
                gap:40px;
            }

            .activitySection{
                padding:10px 20px;
                border:2px solid black;
                border-radius: 5px;
                margin-bottom:30px;
            }

            .activitySectionTitle{
                height: 30px;
                font-weight: 700;
            }

            .activityBar{
                display: flex;
                justify-content: space-between;
                font-size:14px;
                padding:10px 5px;
                border-bottom: 2px solid rgb(226, 221, 221);
                background-color: rgb(212, 210, 210);
            }

            .starIcon{
                width:16px;
                height: 16px;
            }

            .yellowStar{
                display: none;
            }

            .projectDetail{
                width:200px;
                text-align: center;
                position:relative;
            }

            .projectDetailGroup{
                display: flex;
                gap:10px;
                cursor: pointer;
            }

            .activityInfo{
                width:150px;
            }

            .projectName{
                font-size:10px;
            }

            .activityStatus{
                font-size:13px;
                background-color: rgb(218, 217, 217);
                width: fit-content;
                padding:3px 3px;
                margin:auto;
                border-radius: 3px;
            }

            .actionButton{
                border:none;
                width:60px;
                height: 25px;
                background-color: green;
                color:white;
                cursor: pointer;
            }

            .projectPageLink{
                display: flex;
                gap:5px;
                text-decoration: none;
                color: black;
            }

            .projectPageLink:hover{
                text-decoration: underline;
            }

            .linkIcon{
                width:14px;
                height: 14px;
            }

            .activityOptions{
                width:16px;
                height: 16px;
                cursor: pointer;
            }

            .optionMenu {
                display: none;
                width: 80px;
                height: 75px;
                border: 1px solid black;
                border-radius: 5px;
                position: absolute; /* Position relative to the nearest positioned ancestor */
                background-color: white;
                z-index: 1;
                cursor: pointer;
            }

            .optionMenu1 {
                display: none;
                width: 80px;
                height: 25px;
                border: 1px solid black;
                border-radius: 5px;
                position: absolute; /* Position relative to the nearest positioned ancestor */
                background-color: white;
                z-index: 1;
                cursor: pointer;
            }

            .menuOption{
                margin-top: 2px;
                height: 25px;
            }

            .menuOption:hover{
                background-color: gray;
            }



            .teamMembersSection{
                display: none;
            }

            .teamSectionHeaderRow{
                display: flex;
                justify-content: space-between;
                margin-left:60px;
                padding:10px;
                font-size:22px;
                font-weight: 700;
            }

            .teamRow{
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding:10px 10px;
                border-top:1px solid rgb(226, 221, 221);
                font-size: 20px;
            }

            .teamMember{
                display: flex;
                gap:20px;
                align-items: center;
            }

            .teamMemberIcon{
                width:40px;
                height: 40px;
                display: flex;
                justify-content: center;
                align-items: center;
                border-radius: 50%;
                background-color: rgb(236, 234, 234);
            }

            .addTeamMember{
                margin-top:15px;
                display: flex;
                justify-content: flex-end;
                margin-bottom:20px;
            }

            .addTeamMemberButton{
                height: 30px;
                background-color: white;
                color: black;
                cursor:pointer;
                border:2px solid gray;
                border-radius: 4px;
                font-weight: 700;
            }




            .rightSidebar {
                width: 270px;
                border-left: 2px solid rgb(226, 221, 221);
            }

            .profileSection {
                width: 100%;
                cursor: pointer;
            }

            .usernameIcon {
                width: 80px;
                height: 80px;
                display: flex;
                border-radius: 50%;
                margin: 10px auto;
                margin-top: 30px;
                background-color: #b7d1e4;
                color: #2c4778;
                font-size: 30px;
                font-weight: 700;
                justify-content: center;
                align-items: center;
            }

            .username {
                text-align: center;
                font-size: 14px;
                font-weight: 700;
            }

            .useremail {
                font-size: 14px;
                text-align: center;
            }

            .calendarTitle {
                font-size: 13px;
                margin-left: 5px;
                margin-top: 40px;
                font-weight: 900;
                color: #2c4778
            }

            .calendar {
                margin: 10px 5px;
                font-size: 12px;
                background-color: #ecf0f3;
                padding-top: 5px;
                border-radius: 2px;
            }

            .monthHandle {
                margin-left: 5px;
                border-bottom: 1px solid black;
                padding-bottom: 5px;
            }

            .weekdays {
                display: flex;
                justify-content: space-around;
                margin-top: 10px;
            }

            .dateRow {
                display: grid;
                grid-template-columns: auto auto auto auto auto auto auto;
                margin-top: 5px;
            }

            .date {
                padding: 5px;
                text-align: center;
                cursor: pointer;
            }

            .date:hover {
                background-color: rgb(243, 239, 239);
            }

            .reminderSection {
                border: 8px solid rgb(193, 214, 161);
                margin: 5px 5px;
                padding: 5px;
                height: 190px;
            }

            .reminderContainer {
                overflow-y: scroll;
            }

            .reminderTitle {
                font-size: 12px;
                font-weight: 900;
                color: #354e7e;
            }

            .reminderUnit {
                width: 100%;
                display: flex;
                padding: 5px 0px;
                border-bottom: 1px solid black;
            }

            .bellIconDiv {
                width: 23px;
                height: 23px;
                display: flex;
                justify-content: center;
                align-items: center;
                border: 2px solid #354e7e;
                border-radius: 50%;
            }

            .bellIcon {
                width: 20px;
                height: 20px;
            }

            .reminderMessage {
                margin-left: 7px;
                font-size: 12px;
                font-weight: 600;
            }
        </style>
    </head>

    <body>
        <div class="overlay"></div>
        <div class="formSection">
            <form class="activityForm" action="createActivity">
                <div class="formTitle">Create Activity</div>
                <div class="projectNameField">
                    <label for="projectName" class="inputTitle">Activity Name:</label>
                    <input name="activityName" id="activityName" class="inputField projectName" type="text">
                </div>
                <div class="activityTypeField">
                    <label for="activityType" class="inputTitle">Activity Type</label>
                    <select name="activityType" class="activityTypeInput" id="activityType">
                        <option value="select" default>--Select--</option>
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
                            <input name="addTeam" id="addTeam" class="inputField teamMemberField" type="text">
                        </div>
                        <button class="projectTeamMembersButton">Add</button>
                    </div>
                    <div class="projectTeamTags">

                    </div>
                </div>
                <div class="projectDescription">
                    <label for="projectDesc" class="inputTitle">Activity Objectives</label>
                    <textarea name="activityDesc" id="activityDesc" rows="6" cols="10"></textarea>
                </div>
                <div class="projectDeadline">
                    <label for="projectDead" class="inputTitle">Deadline:</label>
                    <input class="deadlineInput" type="date" name="activityDdline" id="activityDdline">
                </div>
                <div class="projectFormButtons">
                    <button class="projectCancelButton">Cancel</button>
                    <button type="submit" class="projectCreateButton">Create</button>
                </div>
            </form>
            <form class="addMemberForm">
                <div class="formTitle">Add Member</div>
                <div class="projectTeamMembers">
                    <div class="projectTeamMembersAddition">
                        <div class="projectTeamMembersInput">
                            <label for="addTeam" class="inputTitle">Assign To</label>
                            <input name="addTeam" class="inputField teamMemberField2" type="text">
                        </div>
                        <button class="projectTeamMembersButton2">Add</button>
                    </div>
                    <div class="projectTeamTags2">

                    </div>
                </div>
                <div class="projectFormButtons">
                    <button class="projectCancelButton">Cancel</button>
                    <button type="submit" class="updateTeamButton">Update</button>
                </div>
            </form>
        </div>
    </div>
    <div class="navbar">
        <div class="leftNavSection">
            <div class="logoSection">
                <img src="">
                <div class="logoText">PlanGeNow</div>
            </div>
            <div class="navs">
                <a href="main.jsp" class="navLink">
                    <div class="unselectedNav">Home</div>
                </a>
                <a href="fetchProjects" class="navLink">
                    <div class="unselectedNav">Projects</div>
                </a>
                <a href="fetchActivitiesForUser?userID=<%= String.valueOf(session.getAttribute("email_op"))%>" class="navLink">
                    <div class="unselectedNav">My Activities</div>
                </a>
            </div>
            <button class="reportsButton">Reports</button>
        </div>
        <div class="rightNavSection">
            <input type="text" placeholder="Search" class="searchBox">
            <a><img class="navImg" src="./assets/bell-icon.png"></a>
            <a href="faq.jsp"><img class="navImg" src="./assets/question.png"></a>
            <a href="profile.jsp"><img class="navImg" src="./assets/settings.jpg"></a>
        </div>
    </div>
    <div class="mainContent">
        <div class="sidebar">
            <a href="../teampage/teampage.html" class="sidebarLink">
                <div class="sidebarOptions">
                    <img class="sidebarOptionsIcon" src="./assets/group.png"></img>
                    <div class="sidebarOptionsText">My Teams</div>
                </div>
            </a>
            <a href="../collaborationpage/collaborationpage.html" class="sidebarLink">
                <div class="sidebarOptions">
                    <img class="sidebarOptionsIcon" src="./assets/collaboration.png"></img>
                    <div class="sidebarOptionsText">My Collaborations</div>
                </div>
            </a>
        </div>
        <div class="mainContainer">
            <div class="mainSection">
                <div class="projectHeader">
                    <img class="projectIcon" src="./assets/project-icon.png">
                    <div class="projectOptions">
                        <div class="projectTitle">Project Title</div>
                        <div class="projectNav">
                            <div class="navOption activeOption">Activities</div>
                            <div class="navOption">Team</div>
                        </div>
                    </div>
                </div>
                <div class="activityTypeSection">
                    <div class="createActivity">
                        <button class="exportButton" onclick="exportData('<%= p_id%>')">Export Data</button>
                        <%
                            String x = project_owner;
                            String y = (String) session.getAttribute("email_op");
                            if (x.equals(y)) {
                        %>
                        <button class="createActivityButton">Create Activity</button>
                        <% } %>
                    </div>
                    <% if (activities != null && !activities.isEmpty()) {
                            for (Map<String, String> activity : activities) {
                                String assigned_to_id = activity.get("assign_to");
                                String sql = "SELECT email FROM users where userID = " + assigned_to_id;
                                pstmt = conn.prepareStatement(sql);
                                rs = pstmt.executeQuery();
                                while (rs.next()) {
                                    email = rs.getString(1);
                                }
                    %>
                    <div class="activitySection">
                        <div class="activitySectionTitle"><%= activity.get("a_status")%></div>
                        <div class="activityBar">
                            <div class="projectDetail projectDetailGroup"><img src="./assets/star.png"
                                                                               class="starIcon whiteStar"><img src="./assets/starYellow.png"
                                                                               class="starIcon yellowStar"><a href="fetchIndividualActivity?ActivityID=<%= activity.get("activity_id")%>">
                                    <div class="activityInfo">
                                        <div class="activityName"><%= activity.get("a_name")%></div>
                                    </div>
                                    <!--                                    <img src="./assets/external-link.png" class="linkIcon">-->
                                </a></div>
                            <div class="projectDetail"><%= email%></div>
                            <div class="projectDetail">Type: <%= activity.get("a_type")%></div>
                            <div class="projectDetail">Deadline: <%= activity.get("ddline")%></div>
                            <div class="projectDetail">
                                <img class="activityOptions" src="./assets/option.png">
                                <%
                                    String a = project_owner;
                                    String b = (String) session.getAttribute("email_op");
                                    if (a.equals(b)) {
                                %>
                                <div class="optionMenu">
                                    <div class="menuOption editOption" onclick="editActivity('<%= activity.get("activity_id")%>')">Edit</div> 
                                    <div class="menuOption deleteOption" onclick="deleteActivity('<%= activity.get("activity_id")%>')">Delete</div>
                                    <div class="menuOption" onclick="goToActivityDetailsPage('<%= activity.get("activity_id")%>')">View</div>
                                </div>
                                <% } else {%>
                                <div class="optionMenu1">
                                    <div class="menuOption viewOption" onclick="goToActivityDetailsPage('<%= activity.get("activity_id")%>')">View</div> 
                                </div>
                                <%}%>
                            </div>
                        </div>
                    </div>
                    <% }
                        }%>
                </div>
                <div class="teamMembersSection">
                    <div class="teamSectionHeaderRow">
                        <div class="teamSectionHeader">Name</div>
                        <div class="teamSectionHeader">Contact Information</div>
                    </div>
                    <%
                        String final_name = null;
                        if (users != null && !users.isEmpty()) {
                            for (Map<String, String> user : users) {
                                if (user.get("name").contains(" ")) {
                                    int spaceIndex = user.get("name").indexOf(" ");
                                    String first_leter_name = user.get("name").substring(0, spaceIndex).toUpperCase();
                                    String second_leter_name = user.get("name").substring(spaceIndex + 1).toUpperCase();
                                    final_name = first_leter_name.charAt(0) + "" + second_leter_name.charAt(0);
                                } else {
                                    String first_leter_name = user.get("name").toUpperCase();
                                    final_name = first_leter_name.charAt(0) + "";
                                }
                    %>
                    <div class="teamRow">
                        <div class="teamMember">
                            <div class="teamMemberIcon">
                                <div><%= final_name%></div>
                            </div>
                            <div class="teamMemberName"><%= user.get("name")%></div>
                        </div>
                        <!--                        <div class="teamMemberRoleSection">
                                                    <div class="teamMemberRole">Team Lead </div>
                                                    <div class="teamMemberRole">UI Designer</div>
                                                    <div class="teamMemberRole">Database Developer</div>
                                                </div>-->
                        <div class="teamMemberContact">
                            <div class="teamMemberEmail"><%= user.get("email")%></div>
                            <!--<div class="teamMemberNumber">+49-123456789</div>-->
                        </div>
                    </div>
                    <% }
                        }%>
                </div>
            </div>
        </div>
        <div class="rightSidebar">
            <div class="profileSection">
                <div class="usernameIcon">
                    <div class="usernameIconText"><%= String.valueOf(session.getAttribute("fName"))%></div>
                </div>
                <div class="username"><%= String.valueOf(session.getAttribute("sName"))%></div>
                <div class="useremail"><%= String.valueOf(session.getAttribute("email"))%></div>
            </div>
            <div class="calendarTitle">Calendar</div>
            <div class="month">December 2024</div>
            <div class="calendar">
                <div class="monthHandle">
                    <div class="month">December 2024</div>
                </div>
                <div class="weekdays">
                    <div class="weekday">Mo</div>
                    <div class="weekday">Tu</div>
                    <div class="weekday">We</div>
                    <div class="weekday">Th</div>
                    <div class="weekday">Fr</div>
                    <div class="weekday">Sa</div>
                    <div class="weekday">Su</div>
                </div>
                <div class="dateSection"><div class="dateRow"><div class="date">&nbsp;</div><div class="date">&nbsp;</div><div class="date">&nbsp;</div><div class="date">&nbsp;</div><div class="date">&nbsp;</div><div class="date">&nbsp;</div><div class="date">1</div></div><div class="dateRow"><div class="date">2</div><div class="date">3</div><div class="date">4</div><div class="date">5</div><div class="date">6</div><div class="date">7</div><div class="date">8</div></div><div class="dateRow"><div class="date">9</div><div class="date">10</div><div class="date">11</div><div class="date">12</div><div class="date">13</div><div class="date">14</div><div class="date">15</div></div><div class="dateRow"><div class="date">16</div><div class="date">17</div><div class="date">18</div><div class="date">19</div><div class="date">20</div><div class="date">21</div><div class="date">22</div></div><div class="dateRow"><div class="date">23</div><div class="date">24</div><div class="date">25</div><div class="date">26</div><div class="date">27</div><div class="date">28</div><div class="date">29</div></div><div class="dateRow"><div class="date">30</div><div class="date">31</div><div class="date">&nbsp;</div><div class="date">&nbsp;</div><div class="date">&nbsp;</div><div class="date">&nbsp;</div><div class="date">&nbsp;</div></div></div>
            </div>
            <div class="reminderSection">
                <div class="reminderTitle">Reminders</div>
                <div class="reminderContainer">
                    <div class="reminderUnit">
                        <div class="bellIconDiv">
                            <img src="./assets/bell.png" class="bellIcon"></img>
                        </div>
                        <div class="reminderMessage">Reminder 1</div>
                    </div>
                    <div class="reminderUnit">
                        <div class="bellIconDiv">
                            <img src="./assets/bell.png" class="bellIcon"></img>
                        </div>
                        <div class="reminderMessage">Reminder 1</div>
                    </div>
                    <div class="reminderUnit">
                        <div class="bellIconDiv">
                            <img src="./assets/bell.png" class="bellIcon"></img>
                        </div>
                        <div class="reminderMessage">Reminder 1</div>
                    </div>
                    <div class="reminderUnit">
                        <div class="bellIconDiv">
                            <img src="./assets/bell.png" class="bellIcon"></img>
                        </div>
                        <div class="reminderMessage">Reminder 1</div>
                    </div>
                </div>
            </div>
        </div>
        <% conn.close();%>
</body>
<script>
    //Right Sidebar

    element = document.querySelector(".dateSection");
    var monthList = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];


    var today = new Date();
    var currentDate = today.getDate();
    var currentMonth = today.getMonth();
    var currentYear = today.getFullYear();

    var day = today.getDay();
    console.log(currentMonth);
    var dayOnFirst = new Date(`${currentYear}-${currentMonth + 1}-01`).getDay();

    var monthElement = document.querySelector(".month").innerHTML = `${monthList[currentMonth]} ${currentYear}`;


        var calendar = [];
        weekMap = [6, 0, 1, 2, 3, 4, 5];
        var i = 0;
        var k = 1;
        var flag = 0;
        while (true) {
            var dateRow = [];
            for (var j = 0; j < 7; j++) {
                if ((i == 0 && j < weekMap[dayOnFirst]) || flag == 1) {
                    dateRow.push(0);
                } else {
                    dateRow.push(k);
                    k++;
                }
                if (k > (30 + currentMonth % 2)) {
                    flag = 1;
                }
            }
            calendar.push(dateRow);
            if (flag == 1)
                break;
            i++;
        }

        console.log(calendar);


        for (var i = 0; i < calendar.length; i++) {
            var singleDiv = `<div class="dateRow">`;
            for (var j = 0; j < 7; j++) {
                if (calendar[i][j] == 0) {
                    singleDiv += `<div class="date">&nbsp;</div>`
                } else {
                    singleDiv += `<div class="date">${calendar[i][j]}</div>`;
                }
            }
            singleDiv += `</div>`
            element.innerHTML += singleDiv;
        }

        // Project Options Navigation

        const sectionList = ['.activityTypeSection', '.teamMembersSection']

        const navList = document.querySelectorAll('.navOption');
        navList.forEach((element, index) => {
            element.addEventListener("click", function (event) {
                const activeNav = document.querySelector('.activeOption');
                activeNav.classList.remove('activeOption');
                event.target.classList.add('activeOption');
                sectionList.forEach((element) => {
                    if (element)
                    {
                        const section = document.querySelector(element);
                        console.log(section);
                        section.style.display = "none";
                    }
                })
                document.querySelector(sectionList[index]).style.display = "block";
            })
        })


        //Create Activity Button

        const createActivityButton = document.querySelector(".createActivityButton");

        createActivityButton.addEventListener("click", function (event) {
            document.querySelector('.overlay').style.display = "block";
            document.querySelector('.formSection').style.display = "block";
            document.querySelector('.activityForm').style.display = "block";
        })



        //Activity Options

        var checkProjectMenu = false;
        const optionIcon = document.querySelectorAll('.activityOptions');
        optionIcon.forEach((element, index) => {
            element.addEventListener("click", function (event) {
                event.stopPropagation();
                const optionMenu = document.querySelectorAll('.optionMenu');
                optionMenu[index].style.display = 'block';
            })
        })

        optionIcon.forEach((element, index) => {
            element.addEventListener("click", function (event) {
                event.stopPropagation();
                const optionMenu1 = document.querySelectorAll('.optionMenu1');
                optionMenu1[index].style.display = 'block';
            })
        })


        window.onclick = function (event) {
            const optionMenu = document.querySelectorAll('.optionMenu')
            optionMenu.forEach((element) => {
                element.style.display = 'none';
            })
        }

        const editOptions = document.querySelectorAll('.editOption');
        editOptions.forEach((element, index) => {
            element.addEventListener("click", function (event) {
                event.stopPropagation();
                const overlay = document.querySelector(".overlay");
                const form = document.querySelector('.formSection');
                overlay.style.display = "block";
                form.style.display = "flex";

            })
        })

        const deleteOptions = document.querySelectorAll('.deleteOption');
        const singleProjectSection = document.querySelectorAll('.singleProjectSection');
        deleteOptions.forEach((element, index) => {
            element.addEventListener("click", function (event) {
                event.stopPropagation();
                console.log(index);
                singleProjectSection[index].style.display = 'none';
            })
        })


        //Add Team Members
        const projectTeamMembersButton = document.querySelector('.projectTeamMembersButton');
        const projectTeamTags = document.querySelector('.projectTeamTags');
        const teamMemberField = document.querySelector('.teamMemberField');
        projectTeamMembersButton.addEventListener("click", function (event) {
            event.preventDefault();
            const inputValue = teamMemberField.value;
            projectTeamTags.innerHTML += `<div class="projectTeamMemberDetails">${inputValue}</div>`;
            teamMemberField.value = "";
        })

        const projectTeamMembersButton2 = document.querySelector('.projectTeamMembersButton2');
        const projectTeamTags2 = document.querySelector('.projectTeamTags2');
        const teamMemberField2 = document.querySelector('.teamMemberField2');
        projectTeamMembersButton2.addEventListener("click", function (event) {
            event.preventDefault();
            const inputValue = teamMemberField2.value;
            projectTeamTags2.innerHTML += `<div class="projectTeamMemberDetails">${inputValue}</div>`;
            teamMemberField2.value = "";
        })

        const projectCancelButton = document.querySelector('.projectCancelButton');
        projectCancelButton.addEventListener("click", function (event) {
            event.preventDefault();
            const overlay = document.querySelector(".overlay");
            const form = document.querySelector('.formSection');
            overlay.style.display = "none";
            form.style.display = "none";
        })


        function exportData(projectID) {
            window.location.href = "exportDataServlet?projectID=" + projectID;
        }

        function editActivity(projectID) {
            window.location.href = "editActivityServlet?projectID=" + projectID;
        }

        function deleteActivity(projectID) {
            var userConfirmed = confirm("Are you sure you want to delete this project?");
            if (userConfirmed) {
                window.location.href = "deleteActivity?projectID=" + projectID;
            }
        }

        function sendList() {
            let list = "varshilbalar@gmail.comvbalar@gmail.com";
//    let input = document.querySelector('.teamMemberField');
//    input.value=list;
            window.location.href = "createProject?addTeam =" + list;
        }

        function goToActivityDetailsPage(actID) {
            window.location.href = "fetchIndividualActivity?ActivityID=" + actID;
        }
</script>

</html>