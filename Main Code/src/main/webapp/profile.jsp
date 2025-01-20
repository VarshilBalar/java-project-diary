<%-- 
    Document   : profile
    Created on : 13 Jan 2025, 9:43:36 pm
    Author     : varsh
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String name = "";
    String mobileNumber = "";
    String bio = "";
    String profilePic = "./assets/default-profile.jpg";
    
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plangenow", "admin", "admin123");
    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM USERS WHERE email='" + String.valueOf(session.getAttribute("email_op")) + "'");
    while (rs.next()) {
        name = rs.getString("name");
        mobileNumber = rs.getString("phone_number") != null ? rs.getString("phone_number") : mobileNumber;
        bio = rs.getString("bio") != null ? rs.getString("bio") : bio;
        profilePic = rs.getString("profile_picture") != null ? rs.getString("profile_picture") : profilePic;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Settings</title>
    <style>
        /* General Reset */
body {
    margin: 0;
    font-family: 'Arial', sans-serif;
    color: #333;
    background: linear-gradient(to bottom right, #A9CDD7, #E1F6F2);
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow-y: auto; /* Enable scrolling on the page */
}

/* Main Container */
.main-container {
    display: flex;
    width: 90%;
    max-width: 1000px;
    height: auto;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    overflow: hidden;
}

/* Side Panel */
.side-panel {
    width: 30%;
    background: linear-gradient(135deg, #83B8C6, #A9E4DE);
    color: white;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 20px;
    position: relative;
    clip-path: polygon(0 0, 100% 0, 100% 100%, 0 90%);
}

.side-panel h2 {
    font-size: 24px;
    margin-bottom: 10px;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
}

.side-panel p {
    text-align: center;
    font-size: 14px;
    margin-bottom: 20px;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
}

/* Geometric Pattern */
.side-panel:after {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('https://via.placeholder.com/300/83B8C6/FFFFFF?text=+');
    opacity: 0.2;
    pointer-events: none;
}

/* Content Container */
.content-container {
    width: 70%;
    padding: 20px;
}

.content-container h1 {
    text-align: center;
    font-size: 24px;
    color: #83B8C6;
    margin-bottom: 15px;
}

/* Profile Picture */
.profile-pic-container {
    text-align: center;
    margin-bottom: 20px;
}

.profile-pic {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    object-fit: cover;
    border: 3px solid #A9E4DE;
}

.edit-pic-btn {
    margin-top: 10px;
    background-color: #A9CDD7;
    color: white;
    border: none;
    padding: 8px 12px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 12px;
}

.edit-pic-btn:hover {
    background-color: #83B8C6;
}

/* Form Styling */
.profile-form {
    margin-top: 10px;
}

.form-group {
    margin-bottom: 10px; /* Reduced spacing between inputs */
}

.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 3px; /* Reduced spacing above input fields */
    color: #333;
}

.form-group input,
.form-group textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    box-sizing: border-box;
}

.form-group input:focus,
.form-group textarea:focus {
    outline: none;
    border-color: #A9CDD7;
}

/* Form Actions */
.form-actions {
    display: flex;
    justify-content: space-between;
    margin-top: 15px;
}

.save-btn,
.cancel-btn {
    padding: 8px 12px;
    border: none;
    font-size: 12px;
    cursor: pointer;
    border-radius: 5px;
    width: 48%;
}

.save-btn {
    background-color: #A9CDD7;
    color: white;
}

.save-btn:hover {
    background-color: #83B8C6;
}

.cancel-btn {
    background-color: #ebebeb;
    color: #333;
}

.cancel-btn:hover {
    background-color: #d6d6d6;
}

    </style>
</head>

<body>
    <div class="main-container">
        <div class="side-panel">
            <h2>Welcome Back!</h2>
            <p>Keep your profile updated to enjoy a seamless experience.</p>
        </div>

        <div class="content-container">
            <h1>Profile Settings</h1>
            <div class="profile-pic-container">
                <img src="./assets/Profile.jpg" alt="Profile Picture" class="profile-pic" id="profilePic">
                <input type="file" id="fileInput" accept="image/*" hidden>
                <button class="edit-pic-btn" onclick="uploadImage()">Edit Picture</button>
            </div>

            <form class="profile-form" action="updateProfile">
                <div class="form-group">
                    <label for="full-name">Full Name</label>
                    <input type="text" id="full-name" name="fName" value="<%= name %>" placeholder="Enter your full name">
                </div>


                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="<%= String.valueOf(session.getAttribute("email_op"))%>" readonly>
                </div>

                <div class="form-group">
                    <label for="phone">Contact Number</label>
                    <input type="tel" id="phone" name="contactNumber" value="<%= mobileNumber %>" placeholder="Enter your phone number">
                </div>

                <div class="form-group">
                    <label for="bio">Bio</label>
                    <textarea id="bio" rows="7" name="bio" placeholder="Tell us something about yourself"><%= bio %></textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="save-btn">Save Changes</button>
                    <button type="reset" class="cancel-btn" onclick="goToMainPage()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function uploadImage() {
            document.getElementById("fileInput").click();
            document.getElementById("fileInput").onchange = function (event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById("profilePic").src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            };
        }
        
        function goToMainPage() {
            window.history.go(-1);
        }
    </script>
</body>

</html>