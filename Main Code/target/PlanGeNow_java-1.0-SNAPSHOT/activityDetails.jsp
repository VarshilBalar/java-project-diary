<%-- 
    Document   : activityDetails
    Created on : 11 Jan 2025, 6:01:49 pm
    Author     : varsh
--%>

<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Map<String, String>> activities = (List<Map<String, String>>) session.getAttribute("individualActivity");
    List<Map<String, String>> challenges = (List<Map<String, String>>) session.getAttribute("chlgs");
    List<Map<String, String>> solutions = (List<Map<String, String>>) session.getAttribute("sol");

    String name = null;
    String obj = null;
    String ddline = null;
    String status = null;
    String type = null;
    String p_id = null;
    String start_date = null;
    String time_spent = null;
    String result = null;
    String checker = "0000-00-00 00:00:00";
    String activity_id = null;
    String assigned_to = (String) session.getAttribute("user_id_for_individual_activity");
    if (activities != null && !activities.isEmpty()) {
        for (Map<String, String> activity : activities) {
            activity_id = activity.get("activity_id");
            type = activity.get("a_type");
            p_id = activity.get("project_id");
            name = activity.get("a_name");
            status = activity.get("a_status");
            obj = activity.get("a_obj");
            ddline = activity.get("ddline");
            time_spent = activity.get("time_spent");
            start_date = activity.get("start_time");
        }
    }

    if (checker.equals(start_date)) {
        start_date = "Activity Not Started";
        time_spent = "Activity Not Started";
    } else if (status.equals("In Progress")) {
        LocalDateTime currentTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime storedDateTime = LocalDateTime.parse(start_date, formatter);
        long days = ChronoUnit.DAYS.between(storedDateTime, currentTime);
        long hours = ChronoUnit.HOURS.between(storedDateTime, currentTime) % 24;
        long minutes = ChronoUnit.MINUTES.between(storedDateTime, currentTime) % 60;

        time_spent = String.format("%02dd %02dh %02dm", Math.abs(days), Math.abs(hours), Math.abs(minutes));
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
                gap:20px;
                font-size:14px;
            }

            .navOption{
                padding-bottom:5px;
                cursor: pointer;
            }

            .activeOption{
                border-bottom: 2px solid black;
            }

            .activityDetailsText{
                font-size:16px;
                font-weight: 700;
                color:#354e7e;
                margin-top:20px;
                margin-bottom:10px;
            }

            .activityDetails{
                /* width:100%; */
                height:250px;
                border:1px solid gray;
                border-radius: 14px;
                padding:10px;
            }

            .activityTitleText{
                font-size:14px;
                margin-bottom: 5px;
                color:#354e7e;
            }

            .activityTitle{
                /* width: 100%; */
                padding:4px;
                height: 20px;
                border:1px solid black;
                border-radius: 4px;
            }

            .activityDescriptionText{
                margin-top:10px;
                margin-bottom:5px;
                font-size:14px;
                color:#354e7e;
            }

            .activityDescription{
                padding:4px;
                min-height: 150px;
                border:1px solid black;
                border-radius: 4px;
                /* margin-bottom:4px; */
            }

            .challengesSection{
                display: none;
                height: 550px;
                padding:20px;
                background-color: rgb(246, 246, 246);
                margin-top:20px;
                border-radius: 15px;
            }

            .challengesSectionText{
                padding:20px;
                font-size:16px;
                font-weight: 700;
                color:#354e7e;
            }

            .challengesContainer{
                border:1px dotted black;
                padding:10px 0px;
                height: calc(100% - 100px);
                overflow-y: scroll;
            }

            .challengesContainer::-webkit-scrollbar{
                scroll-behavior: smooth;
                width: 5px;
                background-color: #F5F5F5;
            }

            .challengesContainer::-webkit-scrollbar-thumb {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
                background-color: #f3eded;
            }

            .singleChallUnit{
                display: flex;
                flex-direction: column;
            }

            .challenge{
                width:60%;
                margin:0 10px;
                background-color: white;
                border-radius: 5px;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
                margin-bottom: 10px;
            }

            .challengeText{
                padding:4px 4px;
                font-size:10px;
                border-bottom: 1px solid rgb(236, 233, 233);
                color:gray;
            }

            .challengeQuestion{
                padding:4px;
                font-size:13px;
            }

            .replySection{
                padding:4px 4px;
                border-top:1px solid rgb(236, 233, 233);
                font-size:10px;
                color:gray;
                display: flex;
                justify-content: flex-end;
                align-items: center;
            }

            .replyFacility{
                display: flex;
                justify-content: flex-end;
                align-items: center;
                cursor: pointer;
                width:90px;
            }

            .replyAbility{
                display: none;
                width:98%;
            }

            .replyInput{
                width:98%;
                border:1px solid gray;
                min-height: 50px;
            }

            .replyIcon{
                width:14px;
                height: 14px;
            }

            .solutionText{
                padding:4px 4px;
                font-size:10px;
                border-bottom: 1px solid rgb(83, 82, 82);
                color:gray;
            }

            .solution{
                width:60%;
                margin:0 10px;
                background-color: rgb(198, 241, 251);
                border-radius: 5px;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
                margin-bottom:10px;
                justify-self: end;
            }

            .solutionAnswer{
                padding:4px;
                font-size:13px;
            }




            .rightSidebar {
                width: 270px;
                border-left: 2px solid rgb(226, 221, 221);
            }

            .activityInfoSection{
                margin:18px;
                display: flex;
                flex-direction: column;
                gap:15px;
            }

            .activityInfoContainer{
                width:90%;
                background-color: rgb(145, 250, 211);
                border:2px solid rgb(54, 120, 252);
                border-radius: 10px;
                padding:10px;
            }

            .activityInfoTitle{
                width: fit-content;
                color: rgb(54, 120, 252);
                margin-bottom: 10px;
                font-weight: 700;
            }

            .assignedToName{
                width:fit-content;
                font-size:14px;
            }

            .assignedToEmail{
                width:fit-content;
                font-size:10px;
            }

            .activityInfo{
                width:fit-content;
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
                    <a href="main.jsp" class="navLink"><div class="unselectedNav">Home</div></a>
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
                        <img class="projectIcon" src="./assets/clipboard.png">
                        <div class="projectOptions">
                            <div class="projectTitle"><%= name%></div>
                            <div class="projectNav">
                                <div class="navOption activeOption">Info</div>
                                <div class="navOption">Challenges/Solutions</div>
                            </div>
                        </div>
                    </div>
                    <div class="infoSection">
                        <div class="activityDetailsText">
                            Activity Objectives
                        </div>
                        <div class="activityDetails">
                            <%= obj%>
                        </div>
                    </div>
                    <div class="challengesSection">
                        <div class="challengesSectionText">
                            Challenges/Solutions
                        </div>
                        <%
                            String a = assigned_to;
                            String b = (String) session.getAttribute("email_op");
                            if (a.equals(b)) {
                        %>
                        <form action="addChallenge">
                            <input type="text" name="challenge" required>
                            <button type="submit"><% session.setAttribute("chlg_act_id", activity_id); %>Add Challenge</button>
                        </form>
                        <% } %>
                        <div class="challengesContainer">
                            <div class="singleChallUnit">
                                <%
                                    if (challenges != null && !challenges.isEmpty()) {
                                        for (Map<String, String> chlg : challenges) {
                                %>
                                <!-- Challenge Section -->
                                <div class="challenge">
                                    <div class="challengeText"><%= chlg.get("owner")%></div>
                                    <div class="challengeQuestion"><%= chlg.get("chlg")%></div>
                                    <div class="replySection">
                                        <div class="replyFacility">
                                            <div>Reply</div>
                                            <img src="./assets/reply.png" class="replyIcon">
                                        </div>
                                        <form action="addSolution" method="post" class="replyAbility">
                                            <textarea name="solution" class="replyInput" placeholder="Write your solution here" required></textarea>
                                            <!-- Hidden Inputs for Challenge ID and Activity ID -->
                                            <input type="hidden" name="challenge_id" value="<%= chlg.get("ch_id")%>">
                                            <input type="hidden" name="activity_id" value="<%= chlg.get("a_id")%>">
                                            <div class="replyActions">
                                                <button class="cancelButton" type="button">Cancel</button>
                                                <button type="submit">Send</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <!-- Solutions Section for the Current Challenge -->
                                <div class="solutions">
                                    <%
                                        if (solutions != null && !solutions.isEmpty()) {
                                            boolean hasSolution = false; // Check if the challenge has solutions
                                            for (Map<String, String> sol : solutions) {
                                                if (sol.get("ch_id").equals(chlg.get("ch_id"))) {
                                                    hasSolution = true;
                                    %>
                                    <div class="solutionContainer">
                                        <div class="solution">
                                            <div class="solutionText"><%= sol.get("owner")%></div>
                                            <div class="solutionAnswer"><%= sol.get("sol")%></div>
                                        </div>
                                    </div>
                                    <%
                                            }
                                        }
                                        // If no solutions for this challenge, display a message
                                        if (!hasSolution) {
                                    %>
                                    <div class="noSolutions">No solutions available for this challenge yet.</div>
                                    <%
                                            }
                                        }
                                    %>
                                </div>
                                <%
                                    }
                                } else {
                                %>
                                <!-- No Challenges -->
                                <div class="noChallenges">No challenges available.</div>
                                <%
                                    }
                                %>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="rightSidebar">
                <div class="activityInfoSection">
                    <div class="activityInfoContainer">
                        <div class="activityInfoTitle">Status</div>
                        <div class="activityInfo"><%= status%></div>
                    </div>
                    <div class="activityInfoContainer">
                        <div class="activityInfoTitle">Activity Type</div>
                        <div class="assignedToName"><%= type%></div>
                    </div>
                    <div class="activityInfoContainer">
                        <div class="activityInfoTitle">Assigned To</div>
                        <div class="assignedToName"><%= assigned_to%></div>
                    </div>
                    <div class="activityInfoContainer">
                        <div class="activityInfoTitle">Start Time</div>
                        <div class="activityInfo"><%= start_date%></div>
                    </div>
                    <div class="activityInfoContainer">
                        <div class="activityInfoTitle">Deadline</div>
                        <div class="activityInfo"><%= ddline%></div>
                    </div>
                    <div class="activityInfoContainer">
                        <div class="activityInfoTitle">Time Spent</div>
                        <div class="activityInfo"><%= time_spent%></div>
                    </div>
                </div>
            </div>
            <div>

            </div>
    </body>
    <script>
        const challengesList = {1: "This is a challenge I am facing", 2: "This is a challenge I am facing", 3: "This is a challenge I am facing", 4: "This is a challenge I am facing"};
        //const challengesList = { 1: "This is a challenge I am facing" };
        const solutionList = {1: ["This is a solution", "This is a solution", "This is a solution"], 2: ["This is a solution", "This is a solution"], 3: ["This is a solution", "This is a solution", "This is a solution", "This is a solution"], 4: []}

        var challenges = ""

        for (let key in challengesList) {
            var challenge = `<div class="challengeQuestion">${challengesList[key]}</div>`;
            console.log(challenge);
            var solutionTemplate = `<div class="solutionContainer">`;
            for (let sol of solutionList[key]) {
                // console.log(sol)
                const solution = `<div class="solution">
                                        <div class="solutionText">Solution by user1</div>
                                        <div class="solutionAnswer">${sol}</div>
                                    </div>`
                solutionTemplate += solution;
            }
            solutionTemplate += `</div>`
            var challengeTemplate = `<div class="singleChallUnit">
                                <div class="challenge">
                                    <div class="challengeText">Challenge by username</div>
        ${challenge}
                                    <div class="replySection">
                                        <div class="replyFacility">
                                            <div>Reply</div>
                                            <img src="./assets/reply.png" class="replyIcon">
                                        </div>
                                        <div class="replyAbility">
                                            <textarea class="replyInput" placeholder="Write your solution here"></textarea>
                                            <div class="replyActions">
                                                <button class="cancelButton">Cancel</button>
                                                <button class="sendButton">Send</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
        ${solutionTemplate}
                            </div>`;
            challenges += challengeTemplate;
            solutionTemplate = "";
        }
        //const challengesContainer = document.querySelector('.challengesContainer');
        //challengesContainer.innerHTML = challenges;

        const replyFacility = document.querySelectorAll('.replyFacility');
        const replyAbility = document.querySelectorAll('.replyAbility');
        const replyInput = document.querySelectorAll('.replyInput');
        const cancelRepliesButton = document.querySelectorAll('.cancelButton');
        const sendRepliesButton = document.querySelectorAll('.sendButton');
        var solutionContainer = document.querySelectorAll('.solutionContainer');

        replyFacility.forEach((element, index) => {
            element.addEventListener("click", function (event) {
                replyFacility[index].style.display = "none";
                replyAbility[index].style.display = "block";
            });
        })

        cancelRepliesButton.forEach((element, index) => {
            element.addEventListener("click", function (event) {
                replyAbility[index].style.display = "none";
                replyFacility[index].style.display = "flex";
            });
        })

        sendRepliesButton.forEach((element, index) => {
            element.addEventListener("click", function (event) {
                const inputValue = replyInput[index].value;
                replyAbility[index].style.display = "none";
                replyFacility[index].style.display = "flex";
                const solution = `<div class="solution">
                                        <div class="solutionText">Solution by user1</div>
                                        <div class="solutionAnswer">${inputValue}</div>
                                    </div>`;
                solutionContainer[index].innerHTML += solution;
            })
        })


        //Activity Sections

        const sectionList = ['.infoSection', '.challengesSection']

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

        const projectCancelButton = document.querySelector('.projectCancelButton');
        const overlay = document.querySelector('.overlay');
        const formSection = document.querySelector(".formSection");
        projectCancelButton.addEventListener("click", function (event) {
            overlay.style.display = "none";
            formSection.style.display = "none";
        })

        const createChallengeButton = document.querySelector('.createChallengeButton');
        createChallengeButton.addEventListener("click", function (event) {
            overlay.style.display = "block";
            formSection.style.display = "flex";
        })
    </script>

</html>
