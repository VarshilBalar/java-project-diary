<%-- 
    Document   : mycollaboration
    Created on : 18 Dec 2024, 11:06:58 pm
    Author     : varsh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

            .navLink{
                text-decoration: none;
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


            .columnHeader{
                width:130px;
                text-align: center;
            }

            .headerGroup{
                display: flex;
                gap:10px;
            }

            .projectListSection{
                width:100%;
                display: flex;
                flex-direction: column;
            }

            .projectBar{
                display: flex;
                justify-content: space-between;
                font-size:14px;
                padding:10px 5px;
                border-bottom: 2px solid rgb(226, 221, 221);
            }


            .projectDetail{
                width:120px;
                text-align: center;
            }

            .projectDetailGroup{
                display: flex;
                gap:10px;
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

            .arrowIcon{
                width:16px;
                height: 16px;
                cursor: pointer;
            }

            .projectTeamSection{
                width:98%;
                margin:auto;
                display: none;
                max-height: 250px;
                border: 1px solid rgb(226, 221, 221);
                border-top: none;
                border-bottom-left-radius: 15px;
                border-bottom-right-radius: 15px;
                overflow-y: scroll;
            }

            .teamSectionOpen{
                display: block !important;
            }

            .projectTeamSection::-webkit-scrollbar{
                scroll-behavior: smooth;
                width: 5px;
                background-color: #F5F5F5;
            }

            .projectTeamSection::-webkit-scrollbar-thumb {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
                background-color: #f3eded;
            }

            .teamSectionHeaderRow{
                display: flex;
                justify-content: space-between;
                margin-left:60px;
                padding:10px;
                font-size:12px;
                font-weight: 700;
            }

            .teamRow{
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding:10px 10px;
                border-top:1px solid rgb(226, 221, 221);
                font-size: 12px;
            }

            .teamMember{
                display: flex;
                gap:20px;
                align-items: center;
            }

            .teamMemberIcon{
                width:30px;
                height: 30px;
                display: flex;
                justify-content: center;
                align-items: center;
                border-radius: 50%;
                background-color: rgb(236, 234, 234);
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
                <a href="main.jsp" class="selectedNav"><span class="selectedNavText">Home</span></a>
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
                <a href="team.jsp" class="navLink"><div class="sidebarOptionsText">My Teams</div></a>
            </div>
            <div class="sidebarOptions sidebarOptionActive">
                <img class="sidebarOptionsIcon" src="./assets/collaboration.png"></img>
                <a href="javascript:void(0)" class="navLink"><div class="sidebarOptionsText">My Collaborations</div></a>
            </div>
        </div>
        <div class="mainContainer">
            <div class="mainSection">
                <div class="columnHeaderBar">
                    <div class="columnHeader headerGroup"><img src="./assets/starBlack.png" class="starIcon">
                        <div>Activity Name</div>
                    </div>
                    <div class="columnHeader">Status</div>
                    <div class="columnHeader">Collaborations</div>
                </div>
                <div class="projectListSection">
                    <div class="singleProjectSection">
                        <div class="projectBar">
                            <div class="projectDetail projectDetailGroup"><img src="./assets/star.png"
                                                                               class="starIcon whiteStar"><img src="./assets/starYellow.png"
                                                                               class="starIcon yellowStar"><a class="projectPageLink" href="welcomepage.html">
                                    <div class="activityInfo"><div class="activityName">Activity 1</div><div class="projectName">Project 1</div></div><img src="./assets/external-link.png" class="linkIcon">
                                </a></div>
                            <div class="projectDetail"><div class="activityStatus">To Do</div></div>
                            <div class="projectDetail"><img class="arrowIcon" src="./assets/down-arrow.png"></div>
                        </div>
                        <div class="projectTeamSection">
                            <div class="teamSectionHeaderRow">
                                <div class="teamSectionHeader">Name</div>
                                <div class="teamSectionHeader">Role</div>
                                <div class="teamSectionHeader">Contact Information</div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="singleProjectSection">
                        <div class="projectBar">
                            <div class="projectDetail projectDetailGroup"><img src="./assets/star.png"
                                                                               class="starIcon whiteStar"><img src="./assets/starYellow.png"
                                                                               class="starIcon yellowStar"><a class="projectPageLink" href="welcomepage.html">
                                    <div class="activityInfo"><div class="activityName">Activity 1</div><div class="projectName">Project 1</div></div><img src="./assets/external-link.png" class="linkIcon">
                                </a></div>
                            <div class="projectDetail"><div class="activityStatus">To Do</div></div>
                            <div class="projectDetail"><img class="arrowIcon" src="./assets/down-arrow.png"></div>
                        </div>
                        <div class="projectTeamSection">
                            <div class="teamSectionHeaderRow">
                                <div class="teamSectionHeader">Name</div>
                                <div class="teamSectionHeader">Role</div>
                                <div class="teamSectionHeader">Contact Information</div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="singleProjectSection">
                        <div class="projectBar">
                            <div class="projectDetail projectDetailGroup"><img src="./assets/star.png"
                                                                               class="starIcon whiteStar"><img src="./assets/starYellow.png"
                                                                               class="starIcon yellowStar"><a class="projectPageLink" href="welcomepage.html">
                                    <div class="activityInfo"><div class="activityName">Activity 1</div><div class="projectName">Project 1</div></div><img src="./assets/external-link.png" class="linkIcon">
                                </a></div>
                            <div class="projectDetail"><div class="activityStatus">To Do</div></div>
                            <div class="projectDetail"><img class="arrowIcon" src="./assets/down-arrow.png"></div>
                        </div>
                        <div class="projectTeamSection">
                            <div class="teamSectionHeaderRow">
                                <div class="teamSectionHeader">Name</div>
                                <div class="teamSectionHeader">Role</div>
                                <div class="teamSectionHeader">Contact Information</div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="singleProjectSection">
                        <div class="projectBar">
                            <div class="projectDetail projectDetailGroup"><img src="./assets/star.png"
                                                                               class="starIcon whiteStar"><img src="./assets/starYellow.png"
                                                                               class="starIcon yellowStar"><a class="projectPageLink" href="welcomepage.html">
                                    <div class= "activityInfo"><div class="activityName">Activity 1</div><div class="projectName">Project 1</div></div><img src="./assets/external-link.png" class="linkIcon">
                                </a></div>
                            <div class="projectDetail"><div class="activityStatus">To Do</div></div>
                            <div class="projectDetail"><img class="arrowIcon" src="./assets/down-arrow.png"></div>
                        </div>
                        <div class="projectTeamSection">
                            <div class="teamSectionHeaderRow">
                                <div class="teamSectionHeader">Name</div>
                                <div class="teamSectionHeader">Role</div>
                                <div class="teamSectionHeader">Contact Information</div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                            <div class="teamRow">
                                <div class="teamMember">
                                    <div class="teamMemberIcon">
                                        <div>PC</div>
                                    </div>
                                    <div class="teamMemberName">Papri Row Chowdhury</div>
                                </div>
                                <div class="teamMemberRoleSection">
                                    <div class="teamMemberRole">Team Lead </div>
                                    <div class="teamMemberRole">UI Designer</div>
                                    <div class="teamMemberRole">Database Developer</div>
                                </div>
                                <div class="teamMemberContact">
                                    <div class="teamMemberEmail">papri@example.com</div>
                                    <div class="teamMemberNumber">+49-123456789</div>
                                </div>
                            </div>
                        </div>
                    </div>

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


//Arrow Icon Functionality

        const arrowIcons = document.querySelectorAll('.arrowIcon');
        const teamSection = document.querySelectorAll('.projectTeamSection')
        arrowDir = true;

        arrowIcons.forEach((element, index) => {
            element.addEventListener("click", function (event) {
                teamSection[index].classList.toggle('teamSectionOpen')
                if (arrowDir)
                {
                    arrowDir = false;
                    event.target.src = "./assets/up-arrow.png";
                } else
                {
                    arrowDir = true;
                    event.target.src = "./assets/down-arrow.png";
                }
            })
        })




</script>

</html>