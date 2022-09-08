import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quiz"
export default class extends Controller {
  static targets = ["button"]

  static values = {
    correct: String,
  }


  connect() {
    console.log("connect");
  }

  checkResult(event){
    event.preventDefault();
    const button = this.buttonTarget
    console.log(button);
    if (this.correctValue == "correct") {
      button.style.backgroundColor = "green";
    }else{
      button.style.backgroundColor = "red";
    }

  }
}
