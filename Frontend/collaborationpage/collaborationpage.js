element = document.querySelector(".dateSection");
var monthList = ["January","February","March","April","May","June","July","August","September","October","November","December"];


var today = new Date();
var currentDate = today.getDate();
var currentMonth = today.getMonth();
var currentYear = today.getFullYear();

var day = today.getDay();
console.log(currentMonth);
var dayOnFirst = new Date(`${currentYear}-${currentMonth+1}-01`).getDay();

var monthElement = document.querySelector(".month").innerHTML = `${monthList[currentMonth]} ${currentYear}`;


var calendar = [];
weekMap = [6,0,1,2,3,4,5];
var i = 0;
var k = 1;
var flag=0;
while(true)
{
  var dateRow = [];
  for(var j=0;j<7;j++)
  {
    if((i==0 && j<weekMap[dayOnFirst]) || flag==1)
    {
      dateRow.push(0);
    }
    else
    {
      dateRow.push(k);
      k++;
    }
    if(k>(30 + currentMonth%2))
    {
        flag=1;
    }
  }
  calendar.push(dateRow);
  if(flag==1)
    break;
  i++;
}

console.log(calendar);


for(var i = 0;i<calendar.length;i++)
{
  var singleDiv = `<div class="dateRow">`;
  for(var j = 0;j<7;j++)
  {
    if(calendar[i][j]==0)
    {
        singleDiv += `<div class="date">&nbsp;</div>`
    }
    else
    {
      singleDiv+=`<div class="date">${calendar[i][j]}</div>`;
    }
  }
  singleDiv+=`</div>`
  element.innerHTML +=singleDiv;
}

// Favourite Project Functionality

const whiteStars = document.querySelectorAll('.whiteStar');
const yellowStars = document.querySelectorAll('.yellowStar')

whiteStars.forEach((element,index)=>{element.addEventListener("click",function(event){
    event.target.style.display = "none"
    yellowStars[index].style.display = "block";
})});

yellowStars.forEach((element,index)=>{element.addEventListener("click",function(event){
  event.target.style.display = "none"
  whiteStars[index].style.display = "block";
})});


//Arrow Icon Functionality

const arrowIcons = document.querySelectorAll('.arrowIcon');
const teamSection = document.querySelectorAll('.projectTeamSection')
arrowDir = true;

arrowIcons.forEach((element,index)=>{element.addEventListener("click",function(event){
    teamSection[index].classList.toggle('teamSectionOpen')
    if(arrowDir)
    {
        arrowDir = false;
        event.target.src="../assets/up-arrow.png";
    }
    else
    {
        arrowDir = true;
        event.target.src="../assets/down-arrow.png";
    }
})})



