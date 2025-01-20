<%-- 
    Document   : login
    Created on : 23 Nov 2024, 6:36:22 pm
    Author     : varsh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log In</title>
    <style>
        /* General body styles with full background */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-image: url('./assets/background.jpg'); /* Replace 'background.jpg' with your image path */
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* Form container styles */
.container {
    width: 100%;
    max-width: 400px;
    background: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
    padding: 30px; /* Padding around the form */
    border-radius: 10px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    box-sizing: border-box; /* Ensures padding doesn’t affect container width */
}

/* Logo alignment */
.logo img {
    display: block;
    margin: 0 auto 20px; /* Centers logo with spacing */
    max-width: 350px;
}

/* Heading styles */
h1 {
    font-size: 24px;
    color: #172b4d;
    text-align: center;
    margin-bottom: 20px;
}

/* Paragraph text styles */
p {
    color: #6b778c;
    text-align: center;
    margin: 10px 0;
}

/* Form group spacing */
.form-group {
    margin-bottom: 15px;
}

/* Label styles */
label {
    display: block;
    font-size: 14px;
    margin-bottom: 5px;
    color: #172b4d;
}

/* Input field styles */
input[type="text"], input[type="email"], input[type="password"] {
    width: calc(100% - 20px); /* Reduces width slightly for spacing */
    padding: 10px;
    margin: 0 10px; /* Adds space inside the container */
    border: 1px solid #dfe1e6;
    border-radius: 5px;
    font-size: 14px;
    box-sizing: border-box; /* Consistent padding and border */
}

/* Checkbox styles */
input[type="checkbox"] {
    margin-right: 10px;
}

/* Button styles */
.btn {
    display: block;
    width: calc(100% - 20px); /* Matches input width */
    margin: 0 auto;
    padding: 10px;
    background-color: #0052cc;
    color: #ffffff;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

/* Hover effect for buttons */
.btn:hover {
    background-color: #0747a6;
}

/* Links section (e.g., "Already have an account?") */
.links {
    text-align: center;
    margin-top: 20px;
}

.links a {
    color: #0052cc;
    text-decoration: none;
    font-size: 14px;
}

.links a:hover {
    text-decoration: underline;
}

/* Footer styles */
footer {
    text-align: center;
    margin-top: 20px;
    font-size: 12px;
    color: #6b778c;
}

/* Checkbox label improvement */
.form-group-checkbox {
    display: flex;
    align-items: center;
    margin: 0 10px;
}

.form-group-checkbox label {
    font-size: 14px;
    color: #172b4d;
}

    </style>
</head>
<body>
    <div class="container">
        <!-- Logo -->
        <div class="logo">
            <img src="./assets/logo.png" alt="Project Activity Logger Logo">
        </div>

        <!-- Form Title -->
        <h1>Log in to your account</h1>
        <p>Enter your credentials to access your account.</p>

        <!-- Form -->
        <form action="LoginCheck" method="POST">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="Your email address" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="pass" placeholder="Your password" required>
            </div>
            <button type="submit" class="btn">Log In</button>
        </form>

        <!-- Links -->
        <div class="links">
            <p><a href="#">Can't log in?</a> | <a href="register.jsp">Create an account</a></p>
        </div>

        <!-- Footer -->
        <footer>
            <p>By logging in, you agree to our <a href="#">Privacy Policy</a>.</p>
        </footer>
    </div>
</body>
</html>

    </body>
</html>