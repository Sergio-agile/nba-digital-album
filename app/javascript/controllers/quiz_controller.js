import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quiz"
export default class extends Controller {
  static targets = ["button", "message"]

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
      const quizResultMessage = document.getElementById("quiz-result-message");
      quizResultMessage.innerText = "Congratulations! You're anwer is correct! You got a new pack of 5 cards! We're adding this cards to your album next week :)";
      const quizOpenPack = document.getElementById("quiz-open-pack").style.display = "block";
    }else{
      button.style.backgroundColor = "red";
      const quizResultMessage = document.getElementById("quiz-result-message");
      quizResultMessage.innerText = "Sooooo cloze!!! Best luck next time";
      document.getElementById("quiz-try-again").style.display = "block";
    }

  }
}
