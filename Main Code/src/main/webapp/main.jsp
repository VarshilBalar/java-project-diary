<%-- 
    Document   : Main
    Created on : 23 Nov 2024, 6:59:28 pm
    Author     : varsh
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String name = null;
    String final_name = "UN";
%>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow", "admin", "admin123");
    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT name FROM USERS WHERE email='" + String.valueOf(session.getAttribute("email_op")) + "'");
    while (rs.next()) {
        name = rs.getString("name");
    }
    if (name.contains(" ")) {
        int spaceIndex = name.indexOf(" ");
        String first_leter_name = name.substring(0, spaceIndex).toUpperCase();
        String second_leter_name = name.substring(spaceIndex + 1).toUpperCase();
        final_name = first_leter_name.charAt(0) + "" + second_leter_name.charAt(0);
    } else {
        String first_leter_name = name.toUpperCase();
        final_name = first_leter_name.charAt(0) + "";
    }
%>
<!Doctype html>
<html lang="en-US">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width" />
        <title>Home page</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                height: 100vh;
                font-family: Arial, Helvetica, sans-serif;
            }

            a {
                display: block;
                text-decoration: none;
                color: black;
            }

            .navbar {
                display: flex;
                justify-content: space-between;
                width: 100%;
                height: 50px;
                align-items: center;
                border-bottom: 2px solid rgb(226, 221, 221);
            }

            .leftNavSection {
                display: flex;
                height: 100%;
                align-items: center;
            }

            .logoSection {
                display: flex;
                gap: 10px;
            }

            .logo {
                width: 32px;
                height: 32px;
            }

            .logoText {
                font-size: 23px;
                color: #809bce;
                font-weight: 700;
            }

            .navs {
                display: flex;
                gap: 15px;
                margin-left: 70px;
                height: 100%;
                align-items: center;
                font-size: 14px;
            }

            .selectedNav {
                display: flex;
                height: 100%;
                border-bottom: 3.5px solid #2c4778;
                align-items: center;
                text-decoration: none;
            }

            .selectedNavText {
                color: #2c4778;
                font-weight: 600;
            }

            .unselectedNav {
                color: #354e7e;
            }

            .reportsButton {
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

            .searchBox {
                height: 25px;
                border: 1px solid gray;
                border-radius: 4px;
                margin-right: 10px;
            }

            .mainContent {
                display: flex;
                height: calc(100% - 52px);
                justify-content: space-between;
            }

            .sidebar {
                display: flex;
                flex-direction: column;
                width: 200px;
                gap: 10px;
                padding-top: 25px;
                border-right: 2px solid rgb(226, 221, 221);
            }

            .sidebarOptions {
                width: 100%;
                display: flex;
                padding: 5px 14px;
                gap: 15px;
                cursor: pointer;
            }

            .sidebarOptionsIcon {
                width: 22px;
                height: 22px;
            }

            .sidebarOptionsText {
                font-size: 13px;
                color: rgb(102, 101, 101);
            }

            .mainContainer {
                width: calc(100% - 400px);
                overflow-y: scroll;
                scroll-behavior: smooth;
            }

            .mainContainer::-webkit-scrollbar {
                width: 5px;
                background-color: #F5F5F5;
            }

            .mainContainer::-webkit-scrollbar-thumb {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
                background-color: #f3eded;
            }

            .mainSection {
                margin: 20px 20px;
            }

            .welcomeUser {
                color: #2c4778;
                font-size: 20px;
                font-weight: 900;
            }

            .messageSection {
                margin-top: 10px;
                font-size: 13px;
            }

            .welcomeOptionsSection {
                margin-top: 50px;
                display: flex;
                gap: 15px;
                margin-left: 10px;
            }

            .optionCard {
                width: 140px;
                height: 120px;
                border: 2px solid rgb(226, 221, 221);
                border-radius: 5px;
                cursor: pointer;
            }

            .grayArea {
                background-color: rgb(245, 245, 245);
                width: 130px;
                height: 80px;
                margin: 5px auto;
                display: flex;
                align-items: center;
            }

            .cardText {
                margin-left: 5px;
                font-size: 12px;
            }

            .cardIconArea {
                background-color: white;
                width: 33px;
                height: 33px;
                margin: auto auto;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .cardIcon {
                width: 32px;
                height: 32px;
            }

            .guidedSetupText {
                font-size: 12px;
                font-weight: 900;
                margin-top: 40px;
                color: #2c4778;
            }

            .stepCardSection {
                display: flex;
                gap: 15px;
                margin-top: 10px;
            }

            .stepCard {
                width: 140px;
                height: 120px;
                border: 2px solid rgb(226, 221, 221);
                border-radius: 5px;
                cursor: pointer;
            }

            .oddArea {
                background-color: #b8e0d2;
                width: 130px;
                height: 80px;
                margin: 5px auto;
            }

            .evenArea {
                background-color: #fcf4dd;
                width: 130px;
                height: 80px;
                margin: 5px auto;
            }

            .step {
                width: 120px;
                height: 70px;
                margin: auto;
                padding-top: 5px;
            }

            .stepNumber {
                font-size: 13px;
                font-weight: 900;
            }

            .stepAreaMessage {
                font-size: 11px;
            }

            .stepCardText {
                font-size: 11px;
                font-weight: 900;
                margin-left: 5px;
            }

            .recentSection {
                display: flex;
                justify-content: space-between;
                margin-top: 50px;
            }

            .recentSectionNavigation {
                display: flex;
                width: 100%;
                height: 40px;
                align-items: center;
                margin-top: 12px;
                gap: 10px;
                border-bottom: 1px solid rgb(226, 221, 221);
            }

            .recentSectionNav {
                display: flex;
                align-items: center;
                font-size: 13px;
                height: 100%;
                font-weight: 700;
            }

            .recentSectionNavSelected {
                border-bottom: 3.5px solid #2c4778;
                color: #2c4778;
                margin-top: 2px;
            }

            .recentText {
                font-size: 14px;
                font-weight: 900;
            }

            .recentActivities {
                margin: 20px 0px;
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .activity {
                display: flex;
                justify-content: space-between;
                cursor: pointer;
                height: 45px;
            }

            .activityInfo {
                margin-left: 10px;

            }

            .activityName {
                margin-top: 5px;
            }

            .activity:hover {
                background-color: rgb(239, 237, 237);
            }

            .projectName {
                font-size: 12px;
                margin-top: 5px;
                color: rgb(164, 162, 162);
            }

            .lastSeen {
                color: rgb(139, 138, 138);
                font-size: 14px;
                margin-right: 5px;
                margin-top: 5px;
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

            .navLink{
                text-decoration: none;
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
        <div class="navbar">
            <div class="leftNavSection">
                <div class="logoSection">
                    <img src="">
                    <div class="logoText">PlanGeNow</div>
                </div>
                <div class="navs">
                    <a href="" class="selectedNav"><span class="selectedNavText">Home</span></a>
                    <a href="fetchProjects" class="navLink"><div class="unselectedNav">Projects</div></a>
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
                <div class="sidebarOptions">
                    <img class="sidebarOptionsIcon" src="./assets/group.png"></img>
                    <a href="team.jsp" class="navLink"><div class="sidebarOptionsText">My Team</div><a>
                            </div>
                            <div class="sidebarOptions">
                                <img class="sidebarOptionsIcon" src="./assets/collaboration.png"></img>
                                <a href="mycollaboration.jsp" class="navLink"><div class="sidebarOptionsText">My Collaborations</div></a>
                            </div>
                            </div>
                            <div class="mainContainer">
                                <div class="mainSection">
                                    <div class="welcomeUser">Welcome to PlanGeNow, User's Name!</div>
                                    <div class="messageSection">
                                        <div class="firstMessage">Your journey to better project management starts here.</div>
                                        <div class="secondMessage">Let's track progress, reflect on achievements, and make every activity count!</div>
                                    </div>
                                    <div class="welcomeOptionsSection">
                                        <div class="optionCard">
                                            <div class="grayArea">
                                                <div class="cardIconArea"><img src="./assets/settings.jpg" class="cardIcon"></div>
                                            </div>
                                            <div class="cardText">Account Settings</div>
                                        </div>
                                        <div class="optionCard">
                                            <div class="grayArea">
                                                <div class="cardIconArea"><img src="./assets/people.jpg" class="cardIcon"></div>
                                            </div>
                                            <div class="cardText">Support</div>
                                        </div>
                                        <div class="optionCard">
                                            <div class="grayArea">
                                                <div class="cardIconArea"><img src="./assets/questionmark.jpg" class="cardIcon"></div>
                                            </div>
                                            <div class="cardText">Community</div>
                                        </div>
                                    </div>
                                    <div class="guidedSetupText">Guided Setup / Onboarding Panel</div>
                                    <div class="stepCardSection">
                                        <div class="stepCard">
                                            <div class="oddArea">
                                                <div class="step">
                                                    <div class="stepNumber">Step 1:</div>
                                                    <div class="stepAreaMessage">Create Your First Project</div>
                                                </div>
                                            </div>
                                            <div class="stepCardText">Create Project</div>
                                        </div>
                                        <div class="stepCard">
                                            <div class="evenArea">
                                                <div class="step">
                                                    <div class="stepNumber">Step 2:</div>
                                                    <div class="stepAreaMessage">Add Your Activities</div>
                                                </div>
                                            </div>
                                            <div class="stepCardText">Add Activities</div>
                                        </div>
                                        <div class="stepCard">
                                            <div class="oddArea">
                                                <div class="step">
                                                    <div class="stepNumber">Step 3:</div>
                                                    <div class="stepAreaMessage">Start Tracking Time</div>
                                                </div>
                                            </div>
                                            <div class="stepCardText">Start Timer</div>
                                        </div>
                                        <div class="stepCard">
                                            <div class="evenArea">
                                                <div class="step">
                                                    <div class="stepNumber">Step 4:</div>
                                                    <div class="stepAreaMessage">Explore the Features</div>
                                                </div>
                                            </div>
                                            <div class="stepCardText">Learn More</div>
                                        </div>
                                    </div>
                                    <div class="recentSection">
                                        <div class="recentText">Recent</div>
                                        <input type="text" class="searchBox" placeholder="Filter By Title">
                                    </div>
                                    <div class="recentActivities">
                                        <div class="activity">
                                            <div class="activityInfo">
                                                <div class="activityName">Activity Name</div>
                                                <div class="projectName">Project Name</div>
                                            </div>
                                            <div class="lastSeen">
                                                6 days ago
                                            </div>
                                        </div>
                                        <div class="activity">
                                            <div class="activityInfo">
                                                <div class="activityName">Activity Name</div>
                                                <div class="projectName">Project Name</div>
                                            </div>
                                            <div class="lastSeen">
                                                6 days ago
                                            </div>
                                        </div>
                                        <div class="activity">
                                            <div class="activityInfo">
                                                <div class="activityName">Activity Name</div>
                                                <div class="projectName">Project Name</div>
                                            </div>
                                            <div class="lastSeen">
                                                6 days ago
                                            </div>
                                        </div>
                                        <div class="activity">
                                            <div class="activityInfo">
                                                <div class="activityName">Activity Name</div>
                                                <div class="projectName">Project Name</div>
                                            </div>
                                            <div class="lastSeen">
                                                6 days ago
                                            </div>
                                        </div>
                                        <div class="activity">
                                            <div class="activityInfo">
                                                <div class="activityName">Activity Name</div>
                                                <div class="projectName">Project Name</div>
                                            </div>
                                            <div class="lastSeen">
                                                6 days ago
                                            </div>
                                        </div>
                                        <div class="activity">
                                            <div class="activityInfo">
                                                <div class="activityName">Activity Name</div>
                                                <div class="projectName">Project Name</div>
                                            </div>
                                            <div class="lastSeen">
                                                6 days ago
                                            </div>
                                        </div>
                                        <div class="activity">
                                            <div class="activityInfo">
                                                <div class="activityName">Activity Name</div>
                                                <div class="projectName">Project Name</div>
                                            </div>
                                            <div class="lastSeen">
                                                6 days ago
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="rightSidebar">
                                <div class="profileSection">
                                    <div class="usernameIcon">
                                        <div class="usernameIconText"><%= final_name %></div>
                                    </div>
                                    <div class="username"><%= name %></div>
                                    <div class="useremail"><%= String.valueOf(session.getAttribute("email_op")) %></div>
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
                                var dayOnFirst = new Date(`${currentYear}-${currentMonth+1}-01`).getDay();

                                var monthElement = document.querySelector(".month").innerHTML = `${monthList[currentMonth]} ${currentYear}`;


                                    var calendar = [];
                                    weekMap = [6, 0, 1, 2, 3, 4, 5];
                                    var i = 0;
                                    var k = 1;
                                    var flag = 0;
                                    while (true)
                                    {
                                        var dateRow = [];
                                        for (var j = 0; j < 7; j++)
                                        {
                                            if ((i == 0 && j < weekMap[dayOnFirst]) || flag == 1)
                                            {
                                                dateRow.push(0);
                                            } else
                                            {
                                                dateRow.push(k);
                                                k++;
                                            }
                                            if (k > (30 + currentMonth % 2))
                                            {
                                                flag = 1;
                                            }
                                        }
                                        calendar.push(dateRow);
                                        if (flag == 1)
                                            break;
                                        i++;
                                    }


                                    for (var i = 0; i < calendar.length; i++)
                                    {
                                        var singleDiv = `<div class="dateRow">`;
                                        for (var j = 0; j < 7; j++)
                                        {
                                            if (calendar[i][j] == 0)
                                            {
                                                singleDiv += `<div class="date"> </div>`
                                            } else
                                            {
                                                singleDiv += `<div class="date">${calendar[i][j]}</div>`;
                                            }
                                        }
                                        singleDiv += `</div>`
                                        element.innerHTML += singleDiv;
                                    }
                            </script>

                            </html>

                            <%
                                session.setAttribute("fName", final_name);
                                session.setAttribute("sName", name);
                                session.setAttribute("email", String.valueOf(session.getAttribute("email_op")));
                            %>