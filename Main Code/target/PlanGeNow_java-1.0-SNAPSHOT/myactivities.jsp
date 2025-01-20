<%-- 
    Document   : myactivities
    Created on : 18 Dec 2024, 10:16:58 am
    Author     : varsh
--%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!Doctype html>
<%
    List<Map<String, String>> activities = (List<Map<String, String>>) session.getAttribute("individualActivityForUser");
    Connection conn = null;
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow", "admin", "admin123");
%>
<html lang="en-US">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width" />
        <title>Your Activities</title>
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
            .overlay{
                width:100%;
                height: 100%;
                background-color: black;
                opacity: 0.6;
                z-index: 1;
                position: absolute;
            }

            .formSection{
                width:100%;
                height: 100%;
                position: absolute;
                z-index: 2;
                display: flex;
            }

            .form{
                width:400px;
                height: 500px;
                margin:auto;
                background-color: white;
                border:1px solid black;
                border-radius: 4px;
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

            .sidebarOptions{
                width:100%;
                display: flex;
                padding: 5px 14px;
                gap:15px;
                cursor:pointer;
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
                width:130px;
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
                width:100px;
                text-align: center;
            }

            .projectDetailGroup{
                display: flex;
                gap:10px;
                cursor: pointer;
            }

            .activityInfo{
                width:120px;
            }

            .projectName{
                font-size:10px;
                text-align: end;
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

            .navLink{
                text-decoration: none;
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

            button.actionButton {
                padding: 5px 10px;
                font-size: 15px;
                cursor: pointer;
                border: none;
                transition: background-color 0.3s, color 0.3s;
            }

            /* Green button (Start state) */
            button.actionButton.green {
                background-color: green;
                color: white;
            }

            /* Red button (Finish state) */
            button.actionButton.red {
                background-color: red;
                color: white;
            }


        </style>
    </head>

    <body>
        <!-- <div class="overlay"></div>
        <div class="formSection">
          <div class="form">
              <div>Create Project</div>
          </div> -->
    </div>
    <div class="navbar">
        <div class="leftNavSection">
            <div class="logoSection">
                <img src="">
                <div class="logoText">PlanGeNow</div>
            </div>
            <div class="navs">
                <a href="main.jsp" class="navLink"><div class="unselectedNav">Home</div></a>
                <a href="fetchProjects" class="navLink"><div class="unselectedNav">Projects</div></a>
                <a href="" class="selectedNav"><span class="selectedNavText">My Activities</span></a>
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
                <a href="team.jsp" class="navLink"><div class="sidebarOptionsText">My Team</div></a>
            </div>
            <div class="sidebarOptions">
                <img class="sidebarOptionsIcon" src="./assets/collaboration.png"></img>
                <a href="collaboration.jsp" class="navLink"><div class="sidebarOptionsText">My Collaborations</div></a>
            </div>
        </div>
        <div class="mainContainer">
            <div class="mainSection">
                <div class="projectHeader">
                    <div class="projectTitle">My Activities</div>
                    <!-- <button class="createProjectButton">Create Project</button> -->
                </div>
                <div class="projectFilterArea">
                    <input type="text" class="searchProjectsInput" placeholder="Search Projects" >
                    <select class="typeInput" name="type">
                        <option value="all">All Activities</option>
                        <option value="fav">Favourites</option>
                        <option value="todo">To Do</option>
                        <option value="inpro">In Progress</option>
                        <option value="fin">Finished</option>
                    </select>
                </div>
                <div class="columnHeaderBar">
                    <div class="columnHeader headerGroup"><img src="./assets/starBlack.png" class="starIcon"><div>Activity Name</div></div>
                    <div class="columnHeader">Status</div>
                    <div class="columnHeader">Type</div>
                    <div class="columnHeader">Time Spent</div>
                    <div class="columnHeader">Actions</div>
                </div>
                <div class="projectListSection">
                    <%
                        if (activities != null && !activities.isEmpty()) {
                            for (Map<String, String> activity : activities) {
                                String p_id = activity.get("project_id");
                                String project_name = null;
                                String sql = "SELECT project_name FROM projects where project_id = " + p_id;
                                PreparedStatement pstmt = conn.prepareStatement(sql);
                                ResultSet rs = pstmt.executeQuery();
                                while (rs.next()) {
                                    project_name = rs.getString(1);
                                }

                    %>
                    <div class="projectBar">
                        <div class="projectDetail projectDetailGroup"><img src="./assets/star.png" class="starIcon whiteStar"><img src="./assets/starYellow.png" class="starIcon yellowStar"><a class="projectPageLink" href="fetchIndividualActivity?ActivityID=<%= activity.get("activity_id")%>">
                                <div class="activityInfo"><div class="activityName"><%= activity.get("a_name")%></div><div class="projectName"><%= project_name%></div></div><img src="./assets/external-link.png" class="linkIcon">
                            </a></div>
                        <div class="projectDetail"><div class="activityStatus"><%= activity.get("a_status")%></div></div>
                        <div class="projectDetail"><%= activity.get("a_type")%></div>
                        <div class="projectDetail"><%= activity.get("time_spent")%></div>
                        <!--<div class="projectDetail"><button id="actionButton<%= activity.get("activity_id")%>" class="actionButton" onclick="updateStartTime('<%= activity.get("activity_id")%>')">Start</button></div>-->
                        <%
                            String startTime = activity.get("start_time");
                            String buttonColor = (startTime == null) ? "green" : "red";
                            String buttonText = (startTime == null) ? "Start" : "Finish";
                        %>
                        <div class="projectDetail"><button id="actionButton<%= activity.get("activity_id")%>" class="actionButton <%= buttonColor%>" data-id="<%= activity.get("activity_id")%>" onclick="handleButtonClick(<%= activity.get("activity_id")%>, '<%= startTime%>')">
                                <%= buttonText%>
                            </button></div>
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

        console.log(calendar);


        for (var i = 0; i < calendar.length; i++)
        {
            var singleDiv = `<div class="dateRow">`;
            for (var j = 0; j < 7; j++)
            {
                if (calendar[i][j] == 0)
                {
                    singleDiv += `<div class="date">&nbsp;</div>`
                } else
                {
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



// Action Button Functionality

        const actionButtons = document.querySelectorAll('.actionButton');

        actionButtons.forEach((element, index) => {
            element.addEventListener("click", function (event) {
                event.target.style.backgroundColor = "red";
                event.target.innerText = "Finish";
            })
        });


        function handleButtonClick(activityId, startTime) {
            var button = document.getElementById("actionButton" + activityId);

            // Check if startTime is either null, empty, or an invalid date
            if (startTime === null || startTime.trim() === "" || startTime === "null") {
                window.location.href = "updateTiming?activity_id=" + activityId;
            } else {
                window.location.href = "endActivityTiming?activity_id=" + activityId;
            }
        }


        function goToDetailPage(actID) {
            window.location.href = "fetchIndividualActivity?ActivityID=" + actID;
        }
</script>

</html>