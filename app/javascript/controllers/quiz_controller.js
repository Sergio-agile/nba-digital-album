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
            button.style.backgroundColor = "#3e753b";
            // button.style.backgroundColor = "#007A33";
            const quizResultMessage = document.getElementById("quiz-result-message");
            quizResultMessage.innerText = "Congratulations! Your answer is correct! You won a new pack of 5 cards!";
            quizResultMessage.style.backgroundColor = "#F4A460";
            // quizResultMessage.style.backgroundColor = "#AA76D8";
            quizResultMessage.style.opacity = 0.7;
            quizResultMessage.style.display = "block";
            const quizOpenPack = document.getElementById("quiz-open-pack").style.display = "block";
        } else {
            button.style.backgroundColor = "#B22222";
            // button.style.backgroundColor = "#C8102E";
            const quizResultMessage = document.getElementById("quiz-result-message");
            quizResultMessage.innerText = "Sooooo cloze!!! Best luck next time";
            quizResultMessage.style.backgroundColor = "#F4A460";
            // quizResultMessage.style.backgroundColor = "#AA76D8";
            quizResultMessage.style.opacity = 0.7;
            quizResultMessage.style.display = "block";
            document.getElementById("quiz-try-another").style.display = "block";
        }

    }
}
