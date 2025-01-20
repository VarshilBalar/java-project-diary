<%-- 
    Document   : faq
    Created on : 13 Jan 2025, 9:40:49 pm
    Author     : varsh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>FAQ</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
    body{
    margin:0;
    padding:0;
    font-family: Arial, Helvetica, sans-serif;
    font-size: 16px;
    display: flex;
    flex-direction: column;
}
.header h1{
    font-size: 10px;
}
a {
    text-decoration: none;
    color: black;   
}  
.navbar2{
    width:100%;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 2px solid;
    border-color: rgb(142, 173, 202);
    font-size: 20px;
}

.leftSection{
    margin-left: 60px;
    display: flex;
    gap:25px;
    align-items: center;
}

.rightSection{
    margin-right: 60px;
    display: flex;
    gap:20px;
    align-items: center;
}

.homeIcon{
    width:20x;
    height:20px;
    cursor:pointer;
}

.aboutUs{
    cursor:pointer;
}

.contactUs{
    cursor:pointer;
}

.loginBtn{
    font-weight: 700;
    cursor: pointer;
}

.loginLink{
    text-decoration: none;
    color:black;
}

.signupBtn{
    width:85px;
    height:35px;
    font-size:16px;
    border:none;
    border-radius:16px;
    font-weight: 700;
    background-color: black;
    color:white;
    cursor:pointer;
}

.container  {
    display: flex;
    justify-content: space-evenly;
    width: 100%;
    height : auto;
    gap: 20px;
    margin-bottom: 10px;
}
    .contact-section{
        display: flex;
        justify-content: center;
        width: 80%;
        height : auto;
        gap: 200px;
        margin-top: -170px;
        margin-bottom: 20px;
        z-index: 3;
        margin-left:auto;
        margin-right:auto;
    }
.FAQ{
    width: 50%;

}
.part2{
    display: flex;
    flex-direction: column;
    width: 40%;
}
.any-question{
    width: 80%;
    height:auto;
    display: flex;
    flex-direction: column;
    align-items: center;
}
.faq-header img{
    width: 40%
}
.any-question img{
    width: 100%;
}
.faq-section {
    max-width: 800px;
    margin: 0px;
    height: 100%;
    gap: 0px;
}
.question-form{
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
.faq-header {
    text-align: center;
    margin-bottom: 5px;
}

.faq-image {
    width: 150px;
    height: auto;
    margin-bottom: 10px;
}

h2 {
    color: #333;
    margin-bottom: 10px;
}

.faq-section p {
    color: #666;
    font-size: 1em;
    line-height: 1;
    margin: 1px;
}

.question-form p {
    font-weight: bold;
    margin-bottom: 10px;
}

.input-group {
    margin-bottom: 5px;
    width: 100%;
    height: 5px;
    font-size: .9em;
}
.faq-section h2 {
    margin: 0px;
    font-size: 1.5em;
}
.input-group input {
    width: 100%;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 10px;
    box-sizing: border-box;
}
.submit {
    margin: auto;
    width: 20%;
}
.submit-btn {
    width: 100%;
    background-color: #0056b3;
    color: white;
    font-size: 0.9em;
    padding: 5px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    
}

.submit-btn:hover {
    background-color: #004494;
}



/* Contact Page CSS */
.container h4{
    font: 16px;
    
}

.contactbg {
background-image: url("../img/background-map.jpg");
background-size: cover;
padding-top: 50px;
}

.nav {
	font-family: Poiret One, Arial, sans-serif;
  background-color: #ffbf80; 
  width: 100%;
  top: 0;
  position: fixed;
}


.nav ul li {
  list-style-type: none;
  float: right;
  padding: 20px 40px 20px;

}
form{
    width:80%;
    height: 2px;
}
.nav ul li a {
  color: white;
  text-transform: uppercase; 
  letter-spacing: 0.05em;
  font-size: 1em;

}

.nav ul li :hover {
  color: black;
  text-decoration: none;
  transition: color 600ms;

}

.header h1 {
	font-size: 2em;
	text-align: center;
}
.ctinfo {
	font-size: 2em;
}

.allcontact{
	color: #ffffcc;

}

.contactinfo ul li {
	list-style-type: none;
	padding: 5px;
}
.contactinfo {
	width: 100%;
	float: left;
}

#contact h3 {
	font-size: 2em;
}

#info {
	font-size: 1.5em;
	width: 100%;
}

/* FAQ Styling */

.faq-body {
	background-image: url("../img/brickwall.jpg");
	background-size: cover;
}

#faqheader {
	text-align: center;
	padding-top: 60px;
	color: white;
	font-family: Arial, Helvetica, sans-serif;

}
.faqnav {
	background-color: red;
}

.panel-title {
	font-size: 1.2em;
	font-family: Arial, Helvetica, sans-serif;
    height: 1em;
}

#collapseOne, #collapseTwo, #collapseThree, #collapseFour, #collapseFive, #collapseSix{
	background-color: whitesmoke;;
}


.contact-form {
    display: flex;
    flex-direction: column;
    align-items: right;
    text-align: center;
    background: white;
    padding: 0.5em;
    width: 40%;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    z-index: 3;
    
    
}

.contact-form h2 {
    color: #333;
    font-size: 2em;
}

.contact-form input[type="text"],
.contact-form input[type="email"],
.contact-form textarea {
    width: 100%;
    padding: 10px;
    margin-top: 6px;
    border: 1px solid #ccc;
    border-radius: 8px;
    box-sizing: border-box; /* Add this line to include padding in width */
}
.contact-input {
    width: 100%;
}
.contact-form button {
    width: 100%;
    background-color: #667eea;
    color: white;
    border: none;
    padding: 12px 20px;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.contact-form button:hover {
    background-color: #5a67d8;
}

.map{
    width: 100%;
    height: 400px;
}
.get-intouch{
    z-index: 3;
    padding: 0 20px;
}
.get-intouch i{
    font-size: 2.5em;
}
.get-intouch-location, .get-intouch-email, .get-intouch-call{
    display: flex;
    align-items: center;
    gap: 20px;

}
.get-intouch-social{
    display: flex;

    gap: 20px;
}
.contact-title{  
    margin-bottom: 20px;
    background-image: url("./assets/vintage-pink-telephone-composition_23-2148913955.png");
    background-size: cover;
    background-position: center;
    text-align: center;
    width: 90%;
    z-index: 1;
    padding: 10px;
    height: 300px;
    margin: auto;
    margin-top: 30px;
    clip-path: polygon(0 0, 100% 0, 100% 100%, 0% 70%); /* Adjust the slant */
}

</style>
</head>
<body>
  <div class="navbar2">
    <div class="leftSection">
        <img class="homeIcon" src="./assets/house.png">
        <div class="aboutUs">About Us</div>
        <div class="contactUs">
            <a href ="#aboutus"> Contact Us </a>
        </div>
    </div>
    <div class="rightSection">
      <a class="loginLink" href="../registration-login/login.html"><div class="loginBtn">Login</div></a>
      <a href="../registration-login/register.html"><button class="signupBtn">Signup</button></a>
    </div>
  </div>
  <div class="header">
    <h1>Frequently Asked Questions</h1>
  </div>
  <div class="container">
    <div class = "FAQ">
      <div class="panel-group" id="accordion">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h4 class="panel-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
              <p>What is Plan GeNow?</p>
              </a>
            </h4>
          </div>
        <div id="collapseOne" class="panel-collapse collapse in">
          <div class="panel-body">
            Plan GeNow is a sophisticated project management and time tracking software designed by OTH Amberg students. It facilitates efficient tracking of project milestones, daily activities, and deadlines, streamlining project workflows seamlessly.
          </div>
        </div>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
              Who can benefit from using Plan GeNow?
            </a>
          </h4>
        </div>
        <div id="collapseTwo" class="panel-collapse collapse">
          <div class="panel-body">
            Plan GeNow is ideal for students, project managers, and teams looking to enhance productivity and manage their projects more effectively. Its intuitive interface makes it accessible for both beginners and experienced users.
          </div>
        </div>
      </div>

      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
              What are the key features of Plan GeNow?
            </a>
          </h4>
        </div>
        <div id="collapseThree" class="panel-collapse collapse">
          <div class="panel-body">
            Key features include:
              <ul>
              <li>Activity logging and milestone tracking</li>
              <li>Visual progress reports that highlight delays and project status</li>
              <li>A centralized hub for all project-related tasks</li>
              </ul>
            </div>
        </div>
      </div> 

      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
              Is Plan GeNow free to use?
            </a>
          </h4>
        </div>
        <div id="collapseFour" class="panel-collapse collapse">
          <div class="panel-body">
            As of now, Plan GeNow is available for use at no cost, particularly for educational purposes. For commercial use, please contact our support team for licensing details.
          </div>
        </div>
      </div>

      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
            Can I collaborate with others using Plan GeNow?
            </a>
          </h4>
        </div>
        <div id="collapseFive" class="panel-collapse collapse">
          <div class="panel-body">
          Yes, Plan GeNow supports multi-user environments, allowing team members to collaborate on projects in real-time, share updates, and manage tasks collectively.
          </div>
        </div>
      </div>
      <div class="panel panel-default">
          <div class="panel-heading">
            <h4 class="panel-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseSix">
                Does Plan GeNow has integrated AI features?
              </a>
            </h4>
          </div>
          <div id="collapseSix" class="panel-collapse collapse">
            <div class="panel-body">
              <p>No, Plan GeNow does not have integrated AI features as of now. However, the team aims to expand its capabilities in the future, including AI-driven features for predicting project timelines.</p>
            </div>
          </div>
        </div>
      </div>
      </div>
      <div class="faq-section">
        <div class="faq-header">
            <img src="./assets/img3.jpg" alt="Frequently Asked Questions" class="faq-image">
            <h2>Any Question?</h2>
            <p>You can ask anything you would like to know more about Plan GeNow</p>
        </div>
        <div class="question-form">
            <form action="submit_form.php" method="post">
                <div class="input-group">
                    <input type="text" name="question" placeholder="Type your question here..." required>
                </div>
                <div class = "submit">
                  <button type="submit" class="submit-btn">Submit</button>
                </div>
            </form>
        </div>
    </div>
    </div>
  </div>

  </div>
  <div class="for-background">
  <div class = "contact-title">
    <h1>Contact Us</h1>
    <p>Plan GeNow is ready to provide the right solution according to your needs</p>
  </div>
  <div class="contact-section">
    <div class="get-intouch">
      <h2>Get in Touch</h2>
      <p>For any queries or feedback, feel free to reach out to us at:</p>
      <div class = "get-intouch-location">
        <div class="location-icon">
        <i class="fas fa-location-dot" style="color: #74C0FC;"></i>
        </div>
        <div class="location-text">
        <h3>Head Office</h3>
        <p>Kaiser-Ludwig-Ring 999</p>
        <p>Amberg, Germany</p>
        </div>
      </div>
      <div class = "get-intouch-email">
        <div class="email-icon">
        <i class="fas fa-envelope" style="color: #74C0FC;"></i>
        </div>
        <div class = "email-text">
        <h3>Email Us</h3>
        <p>papparapa.swp@gmail.com</p>
        <p>swp-04@oth-aw.de</p>
        </div>
      </div>
      <div class = "get-intouch-call">
        <div class="call-icon">
        <i class="fa-solid fa-phone" style="color: #74C0FC;"></i>
        </div>
        <div class = "call-text">
          <h3>Call Us</h3>
          <p>Phone: +49 1773456831</p>
          <p>Fax: +49 8533244523</p>
        </div>
      </div>
      <div class = "get-intouch-social" >
        <i class="fab fa-facebook" style="color: rgb(142, 173, 202);"></i>
        <i class="fab fa-twitter" style="color: rgb(142, 173, 202);"></i>
        <i class="fab fa-instagram" style="color: rgb(142, 173, 202);"></i>
        <i class="fab fa-linkedin" style="color: rgb(142, 173, 202);;"></i>	
      </div>
    </div>
    <div id = "aboutus" class="contact-form">
      <h2>Send us a message</h2>
      <div class ="contact-input">
      <form action="submit_form.php" method="post">
          <div class="input-group">
              <input type="text" name="name" placeholder="Your Name" required>
          </div>
          <div class="input-group">
              <input type="email" name="email" placeholder="Your Email" required>
          </div>
          <div class="input-group">
            <input type="text" name="number" placeholder="Phone Number">
        </div>
          <div class="input-group">
            <input type="text" name="name" placeholder="Subject" required>
        </div>
          <div class="input-group">
              <textarea name="message" rows="6" placeholder="Your Message" required></textarea>
          </div>
          <button type="submit">Send Message</button>
      </form>
      </div>
    </div>
      
  </div>
  </div>
</div>
<div class = "map">
  <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d5188.249573402684!2d11.846081076402372!3d49.44435845929206!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x47a02a48553b2f7f%3A0x11276afbcf00fe!2sUniversity%20of%20Applied%20Sciences%20Amberg-Weiden!5e0!3m2!1sen!2sde!4v1735497403177!5m2!1sen!2sde" frameborder = "0" width = "100%" height = "400px" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
</div>
</div>



</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</html>
