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
      event.target.src = "../assets/up-arrow.png";
    }
    else {
      arrowDir = true;
      event.target.src = "../assets/down-arrow.png";
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
let projectTeam = ""
projectTeamMembersButton.addEventListener("click", function (event) {
  event.preventDefault();
  const inputValue = teamMemberField.value;
  projectTeam += inputValue + " ";
  projectTeamTags.innerHTML += `<div class="projectTeamMemberDetails">${inputValue}</div>`;
  teamMemberField.value = "";
})


//Project Submit
function sendList() {
  const input = document.querySelector('.teamMemberField');
  console.log(projectTeam);
  input.value = projectTeam;
  window.location.href = "";
}


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


window.onclick = function (event) {
  const optionMenu = document.querySelectorAll('.optionMenu')
  optionMenu.forEach((element) => {
    element.style.display = 'none';
  })
}

const editOptions = document.querySelectorAll('.editOption');
editOptions.forEach((element, index) => {
  element.addEventListener("click", function (event) {
    event.stopPropagation();
    const overlay = document.querySelector(".overlay");
    const form = document.querySelector('.formSection');
    overlay.style.display = "block";
    form.style.display = "flex";

  })
})

const deleteOptions = document.querySelectorAll('.deleteOption');
const singleProjectSection = document.querySelectorAll('.singleProjectSection');
deleteOptions.forEach((element, index) => {
  element.addEventListener("click", function (event) {
    event.stopPropagation();
    console.log(index);
    singleProjectSection[index].style.display = 'none';
  })
})


//Graph visualisation

const myCharts = document.querySelectorAll('.myChart')
myCharts.forEach((element, index) => {
  var xValues = ["Completed", "To Do", "In Progress"];
  var yValues = [55, 49, 44];
  var barColors = [
    "#b91d47",
    "#00aba9",
    "#2b5797"
  ];
  new Chart(element,{
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

})

// var xValues = ["Italy", "France", "Spain", "USA", "Argentina"];
// var yValues = [55, 49, 44, 24, 15];
// var barColors = [
//   "#b91d47",
//   "#00aba9",
//   "#2b5797",
//   "#e8c3b9",
//   "#1e7145"
// ];

// new Chart("myChart", {
//   type: "doughnut",
//   data: {
//     labels: xValues,
//     datasets: [{
//       backgroundColor: barColors,
//       data: yValues
//     }]
//   },
//   options: {
//     title: {
//       display: true,
//     }
//   }
// });



