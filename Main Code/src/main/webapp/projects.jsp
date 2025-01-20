<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    List<Map<String, String>> projects = (List<Map<String, String>>) session.getAttribute("projectList");
%>
<!DOCTYPE html>
<html lang="en-US">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width" />
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

            .projectCancelButton{
                display: block;
                width:100px;
                height:28px;
                background-color: white;
                text-decoration: none;
                color: black;
                border:2px solid black;
                text-align: center;
                font-size:14px;
            }

            .overlay{
                width:100%;
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

            .projectFormButtons {
                margin-top: 40px;
                display: flex;
                gap:10px;
            }

            .projectFormButton{
                display: block;
                width:100px;
                height:28px;
                background-color: white;
                text-decoration: none;
                color: black;
                border:2px solid black;
                text-align: center;
                font-size:14px;
            }

            .projectCancelButton{
                display: block;
                width:100px;
                height:28px;
                background-color: white;
                text-decoration: none;
                color: black;
                border:2px solid black;
                text-align: center;
                font-size:14px;
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

            .selectedNav{
                display: flex;
                height: 100%;
                border-bottom: 3.5px solid #2c4778;
                align-items: center;
                text-decoration: none;
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

            .searchBox{
                height: 25px;
                border: 1px solid gray;
                border-radius: 4px;
                margin-right: 10px;
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
            .navImg{
                width:20px;
                height: 20px;
            }
            .sidebarOptions{
                /* width:100%; */
                display: flex;
                padding: 5px 14px;
                gap:15px;
                cursor:pointer;
                text-decoration: none;
            }

            .sidebarOptions:hover{
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
            }

            .mainSection{
                margin:20px 20px;
            }

            .projectHeader{
                display: flex;
                justify-content: space-between;
            }

            .projectTitle{
                font-size: 20px;
            }

            .createProjectButton{
                border:none;
                background-color: rgb(58, 58, 252);
                color:white;
                border-radius: 4px;
                font-size: 12px;
                height: 26px;
                cursor: pointer;
            }

            .projectFilterArea{
                margin-top:20px;
                margin-bottom: 30px;
                display: flex;
                gap:10px;
            }

            .typeInput{
                width:170px;
                height: 27px;
            }

            .graphSection {
                width: 400px;
                height:400px;
            }

            .columnHeaderBar{
                display: flex;
                justify-content: space-between;
                font-size:15px;
                font-weight: 700;
                padding:0 5px;
                padding-bottom:10px;
                border-bottom:2px solid black;
            }

            .starIcon{
                width:16px;
                height: 16px;
            }

            .yellowStar{
                display: none;
            }

            .columnHeader{
                width:100px;
                text-align: center;
            }

            .headerGroup{
                display: flex;
                gap:10px;
            }

            .projectBar{
                display: flex;
                justify-content: space-between;
                font-size:14px;
                padding:10px 5px;
                border-bottom: 2px solid rgb(226, 221, 221);
            }

            .projectDetail{
                width:110px;
                text-align: center;
            }

            .projectDetailGroup{
                display: flex;
                gap:10px;
                cursor: pointer;
            }

            .arrowIcon{
                width:16px;
                height: 16px;
                cursor: pointer;
            }

            .optionIcon{
                width:16px;
                height: 16px;
                cursor:pointer;
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

            .dashboardSection{
                width:98%;
                margin:auto;
                display: none;
                height: 350px;
                border: 1px solid rgb(226, 221, 221);
                border-top: none;
                border-bottom-left-radius: 15px;
                border-bottom-right-radius: 15px;
                overflow-y: scroll;
            }

            .dashboardSectionOpen{
                display: block !important;
            }

            .dashboardSection::-webkit-scrollbar{
                scroll-behavior: smooth;
                width: 5px;
                background-color: #F5F5F5;
            }

            .dashboardSection::-webkit-scrollbar-thumb {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
                background-color: #f3eded;
            }

            .dashboardSectionHeaderRow{
                display: flex;
                justify-content: space-between;
                margin-left:60px;
                padding:10px;
                font-size:12px;
                font-weight: 700;
            }

            .activityCountSection{
                display: flex;
                justify-content: space-between;
                margin:23px 20px;
            }

            .activityCountBox{
                width:140px;
                height: 60px;
                border:4px solid rgb(195, 195, 250);
                padding:7px 10px;
            }

            .timeSpentTitle{
                font-size:18px;
                font-weight: 900;
            }

            .timeSpent{
                color:gray;
                margin-top:5px;
            }

            .activityBoxTitle{
                font-size:12px;
                font-weight: 900;
            }

            .activityCount{
                font-size: 18px;
                font-weight: 900;
            }

            .taskCountText{
                font-size:12px;
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

            .calendarTitle{
                font-size: 13px;
                margin-left:5px;
                margin-top:40px;
                font-weight: 900;
                color:#2c4778
            }

            .calendar{
                margin:10px 5px;
                font-size:12px;
                background-color: #ecf0f3;
                padding-top: 5px;
                border-radius: 2px;
            }

            .monthHandle{
                margin-left:5px;
                border-bottom:1px solid black;
                padding-bottom: 5px;
            }

            .weekdays{
                display: flex;
                justify-content: space-around;
                margin-top:10px;
            }

            .dateRow{
                display: grid;
                grid-template-columns: auto auto auto auto auto auto auto;
                margin-top:5px;
            }

            .date{
                padding:5px;
                text-align: center;
                cursor: pointer;
            }

            .date:hover{
                background-color: rgb(243, 239, 239);
            }

            .reminderSection{
                border:8px solid rgb(193, 214, 161);
                margin:5px 5px;
                padding:5px;
                height: 190px;
            }

            .reminderContainer{
                overflow-y:scroll;
            }

            .reminderTitle{
                font-size:12px;
                font-weight: 900;
                color:#354e7e;
            }

            .reminderUnit{
                width:100%;
                display: flex;
                padding:5px 0px;
                border-bottom:1px solid black;
            }

            .bellIconDiv{
                width: 23px;
                height: 23px;
                display: flex;
                justify-content: center;
                align-items: center;
                border:2px solid #354e7e;
                border-radius: 50%;
            }

            .bellIcon{
                width: 20px;
                height: 20px;
            }

            .reminderMessage{
                margin-left:7px;
                font-size: 12px;
                font-weight: 600;
            }
        </style>
    </head>

    <body>
        <div class="overlay"></div>
        <div class="formSection">
            <form class="form" action="createProject">
                <div class="formTitle">Create Project</div>
                <div class="projectNameField">
                    <label for="projectName" class="inputTitle">Project Name:</label>
                    <input name="projectName" id="projectName" class="inputField projectName" type="text" required>
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
                    <textarea name="projectDesc" id="projectDesc" rows="6" cols="10" required></textarea>
                </div>
                <div class="projectDeadline">
                    <label for="projectDead" class="inputTitle">Deadline:</label>
                    <input class="deadlineInput" name="deadline" id="deadline" type="date" required>
                </div>
                <div class="projectFormButtons">
                    <!--<button type="button" class="projectCancelButton">Cancel</button>-->
                    <button class="projectCancelButton">Cancel</button>
                    <button type="submit" class="projectFormButton" onsubmit="sendList()">Create</button>
                </div>
            </form>
        </div>
        <div class="navbar">
            <div class="leftNavSection">
                <div class="logoSection">
                    <div class="logoText">PlanGeNow</div>
                </div>
                <div class="navs">
                    <a href="main.jsp" class="navLink"><div class="unselectedNav">Home</div></a>
                    <a href="" class="selectedNav"><span class="selectedNavText">Projects</span></a>
                    <a href="fetchActivitiesForUser?userID=<%= String.valueOf(session.getAttribute("email_op"))%>" class="navLink"><div class="unselectedNav">My Activities</div></a>
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
                <a class="sidebarOptions" href="./teampage/teampage.html">
                    <img class="sidebarOptionsIcon" src="./assets/group.png"></img>
                    <div class="sidebarOptionsText">My Team</div>
                </a>
                <a class="sidebarOptions" href="./collaborationpage/collaborationpage.html">
                    <img class="sidebarOptionsIcon" src="./assets/collaboration.png"></img>
                    <div class="sidebarOptionsText">My Collaborations</div>
                </a>
            </div>
            <div class="mainContainer">
                <div class="mainSection">
                    <div class="projectHeader">
                        <div class="projectTitle">Projects</div>
                        <button class="createProjectButton">Create Project</button>
                    </div>
                    <div class="projectFilterArea">
                        <input type="text" class="searchProjectsInput" placeholder="Search Projects">
                        <select class="typeInput" name="type">
                            <option value="all">All Projects</option>
                            <option value="team">Team Managed</option>
                            <option value="indi">Individual</option>
                            <option value="fav">Favorites</option>
                        </select>
                    </div>
                    <div class="columnHeaderBar">
                        <div class="columnHeader headerGroup"><img src="./assets/starBlack.png" class="starIcon">
                            <div>Name</div>
                        </div>
                        <div class="columnHeader">Dashboard</div>
                        <div class="columnHeader">Deadline</div>
                        <div class="columnHeader">Created by</div>
                        <div class="columnHeader">More Actions</div>
                    </div>
                    <div class="projectListSection">
                        <%
                            int index = 0;
                            if (projects != null && !projects.isEmpty()) {
                                for (Map<String, String> project : projects) {
                        %>
                        <div class="singleProjectSection">
                            <div class="projectBar">
                                <div class="projectDetail projectDetailGroup" onclick="goToViewProjectPage('<%= project.get("project_id")%>')">
                                    <img src="./assets/star.png" class="starIcon whiteStar">
                                    <img src="./assets/starYellow.png" class="starIcon yellowStar">
                                    <div><%= project.get("name")%></div>
                                </div>
                                <%
                                    String storedTime = project.get("start_time");
                                    LocalDateTime currentTime = LocalDateTime.now();
                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                    LocalDateTime storedDateTime = LocalDateTime.parse(storedTime, formatter);

                                    long days = ChronoUnit.DAYS.between(storedDateTime, currentTime);
                                    long hours = ChronoUnit.HOURS.between(storedDateTime, currentTime) % 24;
                                    long minutes = ChronoUnit.MINUTES.between(storedDateTime, currentTime) % 60;

                                    String result = String.format("%02dd %02dh %02dm", Math.abs(days), Math.abs(hours), Math.abs(minutes));
                                %>
                                <div class="projectDetail"><img class="arrowIcon" src="./assets/down-arrow.png"></div>
                                <div class="projectDetail"><%= project.get("ddline")%></div>
                                <div class="projectDetail"><%= project.get("crtd_by")%></div>
                                <div class="projectDetail">
                                    <img class="optionIcon" src="./assets/option.png">
                                    <%
                                        String a = project.get("crtd_by");
                                        String b = (String) session.getAttribute("email_op");
                                        if (a.equals(b)) {
                                    %>
                                    <div class="optionMenu">
                                        <div class="menuOption editOption" onclick="editProject('<%= project.get("project_id")%>')">Edit</div> 
                                        <div class="menuOption deleteOption" onclick="deleteProject('<%= project.get("project_id")%>')">Delete</div>
                                        <div class="menuOption" onclick="goToViewProjectPage('<%= project.get("project_id")%>')">View</div>
                                    </div>
                                    <% } else {%>
                                    <div class="optionMenu1">
                                        <div class="menuOption viewOption" onclick="goToViewProjectPage('<%= project.get("project_id")%>')">View</div>
                                    </div>
                                    <% }%>
                                </div> 
                            </div>
                            <div class="dashboardSection">
                                <div class="activityCountSection">
                                    <div class="activityCountBox">
                                        <div class="timeSpentTitle">Time Spent</div>
                                        <div class="timeSpent"><%= result%></div>
                                    </div>
                                    <div class="activityCountBox">
                                        <div class="activityBoxTitle">Completed Activity</div>
                                        <div class="activityCount"><%= project.get("completed")%></div>
                                        <div class="taskCountText">Task Count</div>
                                    </div>
                                    <div class="activityCountBox">
                                        <div class="activityBoxTitle">To Do Activity</div>
                                        <div class="activityCount"><%= project.get("toDo")%></div>
                                        <div class="taskCountText">Task Count</div>
                                    </div>
                                    <div class="activityCountBox">
                                        <div class="activityBoxTitle">In Progress Activity</div>
                                        <div class="activityCount"><%= project.get("inProgress")%></div>
                                        <div class="taskCountText">Task Count</div>
                                    </div>
                                    <div class="activityCountBox">
                                        <div class="activityBoxTitle">Total Activity</div>
                                        <div class="activityCount"><%= Integer.parseInt(project.get("completed")) + Integer.parseInt(project.get("toDo")) + Integer.parseInt(project.get("inProgress"))%></div>
                                        <div class="taskCountText">Task Count</div>
                                    </div>
                                </div>
                                <center><div class="graphSection">
                                        <canvas id="chart<%= index%>" class="myChart"></canvas>
                                    </div></center>
                            </div>
                        </div>

                        <script>
                            if (!window.chartData)
                                window.chartData = [];
                            window.chartData.push({
                                id: "chart<%= index%>",
                                completed: <%= project.get("completed")%>,
                                toDo: <%= project.get("toDo")%>,
                                inProgress: <%= project.get("inProgress")%>
                            });
                        </script>
                        <%
                                index++;
                            }
                        %>
                        <script>
                            document.addEventListener("DOMContentLoaded", () => {
                                window.chartData.forEach((chart) => {
                                    const ctx = document.getElementById(chart.id);
                                    const data = {
                                        labels: ["Completed", "To Do", "In Progress"],
                                        datasets: [{
                                                data: [chart.completed, chart.toDo, chart.inProgress],
                                                backgroundColor: ["#b91d47", "#00aba9", "#2b5797"]
                                            }]
                                    };
                                    new Chart(ctx, {
                                        type: "doughnut",
                                        data: data,
                                        options: {
                                            title: {display: true}
                                        }
                                    });
                                });
                            });
                        </script>
                        <% }%>

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
    </body>
    <script>
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

            // Favourite Project Functionality

            const whiteStars = document.querySelectorAll('.whiteStar');
            const yellowStars = document.querySelectorAll('.yellowStar')

            whiteStars.forEach((element, index) => {
                element.addEventListener("click", function (event) {
                    event.target.style.display = "none"
                    yellowStars[index].style.display = "block";
                })
            });

            yellowStars.forEach((element, index) => {
                element.addEventListener("click", function (event) {
                    event.target.style.display = "none"
                    whiteStars[index].style.display = "block";
                })
            });


            //Arrow functionality
            const arrowIcons = document.querySelectorAll('.arrowIcon');
            const dashboardSection = document.querySelectorAll('.dashboardSection')
            arrowDir = true;

            arrowIcons.forEach((element, index) => {
                element.addEventListener("click", function (event) {
                    dashboardSection[index].classList.toggle('dashboardSectionOpen')
                    if (arrowDir) {
                        arrowDir = false;
                        event.target.src = "./assets/up-arrow.png";
                    } else {
                        arrowDir = true;
                        event.target.src = "./assets/down-arrow.png";
                    }
                })
            })

            //Create Project Functionaliy
            const createFormButton = document.querySelector('.createProjectButton');
            createFormButton.addEventListener("click", function (event) {
                const overlay = document.querySelector(".overlay");
                const form = document.querySelector('.formSection');
                overlay.style.display = "block";
                form.style.display = "flex";
            })

            const projectListSection = document.querySelector('.projectListSection');

            const projectCancelButton = document.querySelector('.projectCancelButton');
            projectCancelButton.addEventListener("click", function (event) {
                event.preventDefault();
                const overlay = document.querySelector(".overlay");
                const form = document.querySelector('.formSection');
                overlay.style.display = "none";
                form.style.display = "none";
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


            //Project Options
            var checkProjectMenu = false;
            const optionIcon = document.querySelectorAll('.optionIcon');
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

            function editProject(projectID) {
                window.location.href = "editProject.jsp?projectID=" + projectID;
            }
            function goToViewProjectPage(projectID) {
                window.location.href = "fetchActivities?projectID=" + projectID;
            }
            function deleteProject(projectID) {
                var userConfirmed = confirm("Are you sure you want to delete this project?");
                if (userConfirmed) {
                    window.location.href = "deleteProject?projectID=" + projectID;
                }
            }
    </script>

</html>
