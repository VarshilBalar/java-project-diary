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
    }
    else {
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
    }
    else {
      singleDiv += `<div class="date">${calendar[i][j]}</div>`;
    }
  }
  singleDiv += `</div>`
  element.innerHTML += singleDiv;
}

// Project Options Navigation

const sectionList = ['.activityTypeSection','.teamMembersSection','.dashboardSection']

const navList = document.querySelectorAll('.navOption');
navList.forEach((element,index)=>{
  element.addEventListener("click",function(event){
    const activeNav = document.querySelector('.activeOption');
    activeNav.classList.remove('activeOption');
    event.target.classList.add('activeOption');
    sectionList.forEach((element)=>{
      if(element)
      {
        const section = document.querySelector(element);
        console.log(section);
        section.style.display="none";
      }
    })
    document.querySelector(sectionList[index]).style.display="block";
  })
})


//Create Activity Button

const createActivityButton = document.querySelector(".createActivityButton");

createActivityButton.addEventListener("click",function(event){
    document.querySelector('.overlay').style.display ="block";
    document.querySelector('.formSection').style.display ="block";
    document.querySelector('.activityForm').style.display ="block";
})


//Add Team Member Button

const addTeamMemberButton = document.querySelector(".addTeamMemberButton");

addTeamMemberButton.addEventListener("click",function(event){
    document.querySelector('.overlay').style.display ="block";
    document.querySelector('.formSection').style.display ="block";
    document.querySelector('.addMemberForm').style.display ="block";
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


window.onclick = function (event) {
  const optionMenu = document.querySelectorAll('.optionMenu')
  optionMenu.forEach((element) => {
    element.style.display = 'none';
  })
}

// const editOptions = document.querySelectorAll('.editOption');
// editOptions.forEach((element, index) => {
//   element.addEventListener("click", function (event) {
//     event.stopPropagation();
//     const overlay = document.querySelector(".overlay");
//     const form = document.querySelector('.formSection');
//     overlay.style.display = "block";
//     form.style.display = "flex";

//   })
// })

// const deleteOptions = document.querySelectorAll('.deleteOption');
// const singleProjectSection = document.querySelectorAll('.singleProjectSection');
// deleteOptions.forEach((element, index) => {
//   element.addEventListener("click", function (event) {
//     event.stopPropagation();
//     console.log(index);
//     singleProjectSection[index].style.display = 'none';
//   })
// })


//Add Team Members
const projectTeamMembersButton = document.querySelector('.projectTeamMembersButton');
const projectTeamTags = document.querySelector('.projectTeamTags');
const teamMemberField = document.querySelector('.teamMemberField');
let activityTeam = "";
projectTeamMembersButton.addEventListener("click", function (event) {
  event.preventDefault();
  const inputValue = teamMemberField.value;
  activityTeam += inputValue + " ";
  projectTeamTags.innerHTML += `<div class="projectTeamMemberDetails">${inputValue}</div>`;
  teamMemberField.value = "";
})

const projectTeamMembersButton2 = document.querySelector('.projectTeamMembersButton2');
const projectTeamTags2 = document.querySelector('.projectTeamTags2');
const teamMemberField2 = document.querySelector('.teamMemberField2');
let newTeamList = ""

projectTeamMembersButton2.addEventListener("click", function (event) {
  event.preventDefault();
  const inputValue = teamMemberField2.value;
  newTeamList += inputValue + " ";
  projectTeamTags2.innerHTML += `<div class="projectTeamMemberDetails">${inputValue}</div>`;
  teamMemberField2.value = "";
})


//Submit Forms

function assignTeam()
{
  const input = document.querySelector('.teamMemberField');
  input.value=activityTeam;
  window.location.href="";
}

function newTeam()
{
  const input = document.querySelector('.teamMemberField2');
  input.value=newTeamList;
  window.location.href="";
}


var xValues = ["Completed", "To Do", "In Progress"];
var yValues = [55, 49, 44];
var barColors = [
  "#b91d47",
  "#00aba9",
  "#2b5797"
];

new Chart("myChart", {
  type: "doughnut",
  data: {
    labels: xValues,
    datasets: [{
      backgroundColor: barColors,
      data: yValues
    }]
  },
  options: {
    title: {
      display: true,
    }
  }
});