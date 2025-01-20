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


for(var i = 0;i<calendar.length;i++)
{
  var singleDiv = `<div class="dateRow">`;
  for(var j = 0;j<7;j++)
  {
    if(calendar[i][j]==0)
    {
        singleDiv += `<div class="date"> </div>`
    }
    else
    {
      singleDiv+=`<div class="date">${calendar[i][j]}</div>`;
    }
  }
  singleDiv+=`</div>`
  element.innerHTML +=singleDiv;
}
