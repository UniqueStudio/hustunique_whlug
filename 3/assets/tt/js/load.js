function Load(){
  this.rap = [
    "What",
    "That",
    "What",
    "That",
    "What",
    "That",
    "What",
    "That",
    "What",
    "That",
    "What",
    "That",
    "What",
    "That",
    "What",
    "That",
    "What",
    "That",
    "What",
    "That",
    "What",
    "That",
    "What",
    "That",
    "What",
    "That"
  ];
  this.count = 0;
  this.show = function(){
    // Create a super div
    var divLine = document.createElement("div");
    divLine.setAttribute("class", "line");

    // Create a left div
    var divLeft = document.createElement("span");
    divLeft.setAttribute("class", "checking");
    divLeft.innerHTML = this.rap[this.count];

    // Create a right div
    var divRight = document.createElement("span");
    divRight.setAttribute("class", "checked");
    divRight.innerHTML = '[<span class="ok">OK</span>]';

    divLine.appendChild(divLeft);
    divLine.appendChild(divRight);
    document.getElementById("display").appendChild(divLine);
    this.count += 1;
  };
  this.test = function(num){
    console.log(this.rap[num]);
  };
}
