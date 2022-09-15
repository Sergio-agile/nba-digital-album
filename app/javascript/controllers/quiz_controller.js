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

    checkResult(event) {
        event.preventDefault();
        const button = this.buttonTarget
        console.log(button);
        if (this.correctValue == "correct") {
            button.style.backgroundColor = "#3e753b"; //green
            // button.style.backgroundColor = "#007A33";
            const quizResultMessage = document.getElementById("quiz-result-message");
            quizResultMessage.innerText = "Congratulations! You won a new pack of 5 cards!";
            quizResultMessage.style.backgroundColor = "rgba(62, 117, 59, 0.7)"; //green
            // quizResultMessage.style.backgroundColor = "#AA76D8";
            // quizResultMessage.style.opacity = 0.7;
            quizResultMessage.style.display = "block";
            const quizOpenPack = document.getElementById("quiz-open-pack").style.display = "block";
        } else {
            button.style.backgroundColor = "#C8102E"; //$red
            // button.style.backgroundColor = "#C8102E";
            const quizResultMessage = document.getElementById("quiz-result-message");
            quizResultMessage.innerText = "Sooooo cloze!!! Best luck next time";
            quizResultMessage.style.backgroundColor = "rgba(200, 16, 46, 0.7)"; //$red
            // quizResultMessage.style.backgroundColor = "#AA76D8";
            // quizResultMessage.style.opacity = 0.7;
            quizResultMessage.style.display = "block";
            document.getElementById("quiz-try-another").style.display = "block";
        }

    }
}
