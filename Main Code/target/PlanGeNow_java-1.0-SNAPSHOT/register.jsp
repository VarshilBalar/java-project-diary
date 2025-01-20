<%-- 
    Document   : register
    Created on : 23 Nov 2024, 6:58:46 pm
    Author     : varsh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <style>
        /* General body styles with full background */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('assets/background.jpg'); /* Replace 'background.jpg' with your image path */
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            height: 100vh; /* Full viewport height */
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Form container styles */
        .container {
            width: 100%;
            max-width: 420px;
            background: rgba(255, 255, 255, 0.95); /* Subtle white overlay */
            padding: 30px;
            border-radius: 12px; /* Softer rounded edges */
            box-shadow: 0px 6px 10px rgba(0, 0, 0, 0.15); /* More prominent shadow for a floating effect */
            box-sizing: border-box;
        }

        /* Logo alignment */
        .logo img {
            display: block;
            margin: 0 auto 20px;
            max-width: 300px;
        }

        /* Heading styles */
        h1 {
            font-size: 24px;
            color: #172b4d;
            text-align: center;
            margin-bottom: 15px;
        }

        /* Paragraph text styles */
        p {
            color: #6b778c;
            text-align: center;
            margin: 5px 0;
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
            width: calc(100% - 20px); /* Keeps inputs within the container */
            padding: 10px;
            margin: 0 10px;
            border: 1px solid #dfe1e6;
            border-radius: 8px; /* Softer input borders */
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        /* Input field focus effect */
        input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus {
            border-color: #0052cc;
            box-shadow: 0 0 5px rgba(0, 82, 204, 0.3);
            outline: none;
        }

        /* Checkbox container for perfect alignment */
        .checkbox-container {
            display: flex;
            align-items: center;
            margin: 10px 10px 20px; /* Added bottom margin for spacing */
        }

        /* Styled checkbox */
        input[type="checkbox"] {
            appearance: none;
            width: 16px;
            height: 16px;
            border: 2px solid #0052cc;
            border-radius: 4px;
            background-color: #ffffff;
            margin-right: 10px;
            cursor: pointer;
            transition: background-color 0.2s ease, border-color 0.2s ease;
        }

        input[type="checkbox"]:checked {
            background-color: #0052cc;
            border-color: #0052cc;
            position: relative;
        }

        input[type="checkbox"]:checked::after {
            content: '✓';
            font-size: 12px;
            color: #ffffff;
            position: absolute;
            left: 3px;
            top: 0px;
        }

        /* Button styles */
        .btn {
            display: block;
            width: calc(100% - 20px);
            margin: 0 auto;
            padding: 10px;
            background-color: #0052cc;
            color: #ffffff;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px; /* Softer button edges */
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0747a6;
        }

        /* Links section */
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
            margin-top: 10px;
            font-size: 12px;
            color: #6b778c;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Logo -->
        <div class="logo">
            <img src="assets/logo.png" alt="Logo"> <!-- Replace with your logo -->
        </div>

        <!-- Form Title -->
        <h1>Sign up for your account</h1>
        <p>Create an Project Tracker account to get started.</p>

        <!-- Form -->
        <form action="RegisterUser" method="POST">
            <div class="form-group">
                <label for="fullname">Full Name</label>
                <input type="text" id="fullname" name="fullname" placeholder="Your full name" required>
            </div>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="Your email address" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create a password" required>
            </div>
            <div class="form-group">
                <label for="confirm-password">Confirm Password</label>
                <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm your password" required>
            </div>
            <div class="checkbox-container">
                <input type="checkbox" id="terms" name="terms" required>
                <label for="terms">I agree to the <a href="#">Terms and Conditions</a></label>
            </div>
            <button type="submit" class="btn">Sign Up</button>
        </form>

        <!-- Links -->
        <div class="links">
            <p>Already have an account? <a href="login.jsp">Log in here</a></p>
        </div>

        <!-- Footer -->
        <footer>
            <p>By signing up, you agree to our <a href="#">Privacy Policy</a>.</p>
        </footer>
    </div>
</body>
</html>
