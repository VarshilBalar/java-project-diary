const challengesList = { 1: "This is a challenge I am facing", 2: "This is a challenge I am facing", 3: "This is a challenge I am facing", 4: "This is a challenge I am facing" };

const solutionList = { 1: ["This is a solution", "This is a solution", "This is a solution"], 2: ["This is a solution", "This is a solution"], 3: ["This is a solution", "This is a solution", "This is a solution", "This is a solution"], 4: [] }

var challenges = ""

for (let key in challengesList) {
    var challenge = `<div class="challengeQuestion">${challengesList[key]}</div>`;
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
                                        <img src="../assets/reply.png" class="replyIcon">
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
const challengesContainer = document.querySelector('.challengesContainer');
challengesContainer.innerHTML = challenges;

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

sendRepliesButton.forEach((element,index)=>{
    element.addEventListener("click",function(event){
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

const sectionList = ['.infoSection','.challengesSection']

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


const projectCancelButton = document.querySelector('.projectCancelButton');
const overlay = document.querySelector('.overlay');
const formSection = document.querySelector(".formSection");
projectCancelButton.addEventListener("click",function(event){
    overlay.style.display = "none";
    formSection.style.display = "none";
})


const createChallengeButton = document.querySelector('.createChallengeButton');
createChallengeButton.addEventListener("click",function(event){
    overlay.style.display = "block";
    formSection.style.display = "flex";
})