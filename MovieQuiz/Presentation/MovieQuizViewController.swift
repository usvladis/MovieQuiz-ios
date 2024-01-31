import UIKit

final class MovieQuizViewController: UIViewController {
    // MARK: - Lifecycle
    
    struct QuizStepViewModel {
        let image: UIImage
        let question: String
        let questionNumber: String
    }
    
    struct QuizQuestion{
        let image: String
        let text: String
        let correctAnswer: Bool
        
    }
    
    private let questions: [QuizQuestion] = [ //Массив с вопросами
        QuizQuestion(image:"The Godfather", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Dark Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Kill Bill", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Avengers", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Deadpool", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Green Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Old", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "The Ice Age Adventures of Buck Wild", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "Tesla", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "Vivarium", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false)
    ]
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //При запуске приложения уже отображается первый вопрос
        let firstQuestion = questions[currentQuestionIndex]
        let firstQuestionStep = convert(model: firstQuestion)
        show(quiz: firstQuestionStep)
        
        
    }
    //Реализуем кнопку Нет
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        let checkAnswer = false
        let currentQuestion = questions[currentQuestionIndex]
        showAnswerResult(isCorrect: checkAnswer == currentQuestion.correctAnswer)
        buttonBlock()
    }
    //Реализуем кнопку Да
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        let checkAnswer = true
        let currentQuestion = questions[currentQuestionIndex]
        showAnswerResult(isCorrect: checkAnswer == currentQuestion.correctAnswer)
        buttonBlock()
    }
    
    private func show(quiz step: QuizStepViewModel) {
        //Скрываем рамку с ответом в начале нового вопроса
        imageView.layer.borderWidth = 0.0

        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1) / 10")
        
        return questionStep
    }
    
    private func showAnswerResult(isCorrect: Bool) { //Показываем результат, красим рамку
        if isCorrect {
            imageView.layer.masksToBounds = true
            imageView.layer.borderColor = UIColor.ypGreen.cgColor
            imageView.layer.borderWidth = 8.0
            correctAnswers += 1
        }else{
            imageView.layer.masksToBounds = true
            imageView.layer.borderColor = UIColor.ypRed.cgColor
            imageView.layer.borderWidth = 8.0
        }
        // Через 1 секунду показываем новый вопрос
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
           self.showNextQuestionOrResult()
        }
    }
    
    private func showNextQuestionOrResult() {
        if currentQuestionIndex == questions.count - 1{
            showAlert() //Выводим алерт в случае если вопросы закончились
        }else{
            currentQuestionIndex += 1
            let newQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: newQuestion)
            show(quiz: viewModel)
        }
    }
    
    private func showAlert() { //Функция для показа алерта
        
        let message = "Вы ответили правильно на \(correctAnswers) из \(questions.count) вопросов."
        let alertController = UIAlertController(title: "Игра закончена!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Сыграть еще раз", style: .default) { _ in
            self.restartQuiz()
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    private func restartQuiz() { //Функция для рестарта приложения
        currentQuestionIndex = 0
        correctAnswers = 0
        let firstQuestion = questions[currentQuestionIndex]
        let firstQuestionStep = convert(model: firstQuestion)
        show(quiz: firstQuestionStep)
    }
    
    private func buttonBlock() { //Функция для блокировки кнопок после нажатия
        noButton.isEnabled = false
        yesButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.noButton.isEnabled = true
            self.yesButton.isEnabled = true
        }
    }
}
    
    



/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
