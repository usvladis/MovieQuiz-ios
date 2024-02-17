import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate, AlertPresenterDelegate {
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    private var alertPresenter: AlertPresenterProtocol?
    private var statisticService: StatisticService?

    
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        questionFactory = QuestionFactory()
        questionFactory?.delegate = self
        alertPresenter = AlertPresenter()
        alertPresenter?.delegate = self
        statisticService = StatisticServiceImplementation()
        
        
        //При запуске приложения уже отображается первый вопрос
        questionFactory?.requestNextQuestion()
        }
        
    // MARK: - QuestionFactoryDelegate
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else { return}
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
//    func didReceiveNextQuestion(question: QuizQuestion?) {
//        guard let question = question else { return}
//        currentQuestion = question
//        let viewModel = convert(model: question)
//        DispatchQueue.main.async { [weak self] in
//            self?.show(quiz: viewModel)
//        }
//    }
    // MARK: - AlertPresenterDelegate

    func show(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    // MARK: - Actions
    //Реализуем кнопку Нет
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        let checkAnswer = false
        guard let currentQuestion = currentQuestion else {return}
        showAnswerResult(isCorrect: checkAnswer == currentQuestion.correctAnswer)
        buttonBlock()
    }
    //Реализуем кнопку Да
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        let checkAnswer = true
        guard let currentQuestion = currentQuestion else {return}
        showAnswerResult(isCorrect: checkAnswer == currentQuestion.correctAnswer)
        buttonBlock()
    }
    // MARK: - Private functions
    private func show(quiz step: QuizStepViewModel) {
        //Скрываем рамку с ответом в начале нового вопроса
        imageView.layer.borderWidth = 0.0

        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1) / \(questionsAmount)")
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
           self.showNextQuestionOrResult()
        }
    }
    
    private func showNextQuestionOrResult() {
        if currentQuestionIndex == questionsAmount - 1{
            statisticService?.store(correct: correctAnswers, total: questionsAmount)
            let totalGames = statisticService?.totalGames ?? 0
            let record = statisticService?.bestGame ?? GameRecord(correct: 0, total: 0, date: Date())
            let accuracy = statisticService!.totalAccuracy
            alertPresenter?.showAlert(model: AlertModel(title: "Игра закончена!", message: "Ваш результат: \(correctAnswers)/\(questionsAmount) \n Количество сыгранных квизов: \(totalGames) \n Рекорд: \(record.correct)/\(record.total) (\(record.date.dateTimeString)) \n Средняя точность: \(String(format: "%.2f", accuracy))%", buttonText: "Сыграть еще раз", completion: { [weak self]  in
                guard let self = self else { return }
                self.restartQuiz()
            }))//Выводим алерт в случае если вопросы закончились
        }else{
            currentQuestionIndex += 1
            self.questionFactory?.requestNextQuestion()
        }
    }
    
    private func restartQuiz() { //Функция для рестарта приложения
        currentQuestionIndex = 0
        correctAnswers = 0
        questionFactory?.requestNextQuestion()
    }
    
    private func buttonBlock() { //Функция для блокировки кнопок после нажатия
        noButton.isEnabled = false
        yesButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.noButton.isEnabled = true
            self.yesButton.isEnabled = true
        }
    }
}
