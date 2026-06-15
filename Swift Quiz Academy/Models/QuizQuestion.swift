//
//  QuizQuestion.swift
//  Swift Quiz Academy
//

import Foundation

struct QuizQuestion {
    let questionBG: String
    let questionEN: String
    let answersBG: [String]
    let answersEN: [String]
    let correctAnswerBG: Int
    let correctAnswerEN: Int

    var text: String {
        questionEN
    }

    var answers: [String] {
        answersEN
    }

    var correctAnswerIndex: Int {
        correctAnswerEN
    }

    init(
        questionBG: String,
        questionEN: String,
        answersBG: [String],
        answersEN: [String],
        correctAnswerBG: Int,
        correctAnswerEN: Int
    ) {
        self.questionBG = questionBG
        self.questionEN = questionEN
        self.answersBG = answersBG
        self.answersEN = answersEN
        self.correctAnswerBG = correctAnswerBG
        self.correctAnswerEN = correctAnswerEN
    }

    init(text: String, answers: [String], correctAnswerIndex: Int) {
        questionEN = text
        questionBG = Self.localizedBulgarianQuestion(for: text)
        answersEN = answers
        answersBG = answers.map { answer in
            Self.localizedBulgarianAnswer(answer)
        }
        correctAnswerEN = correctAnswerIndex
        correctAnswerBG = correctAnswerIndex
    }

    func questionText(for language: AppLanguage) -> String {
        switch language {
        case .bulgarian:
            return questionBG
        case .english:
            return questionEN
        }
    }

    func answers(for language: AppLanguage) -> [String] {
        switch language {
        case .bulgarian:
            return answersBG
        case .english:
            return answersEN
        }
    }

    func correctAnswerIndex(for language: AppLanguage) -> Int {
        switch language {
        case .bulgarian:
            return correctAnswerBG
        case .english:
            return correctAnswerEN
        }
    }

    func correctAnswerText(for language: AppLanguage) -> String {
        let localizedAnswers = answers(for: language)
        let index = correctAnswerIndex(for: language)
        guard localizedAnswers.indices.contains(index) else { return "" }
        return localizedAnswers[index]
    }

    func explanationText(for language: AppLanguage) -> String {
        let correctAnswer = correctAnswerText(for: language)

        switch language {
        case .bulgarian:
            return "Правилният отговор е \"\(correctAnswer)\". Това е ключовата идея зад въпроса и е важно да я разпознаваш, когато пишеш Swift код."
        case .english:
            return "The correct answer is \"\(correctAnswer)\". This is the key idea behind the question and it is important to recognize it when writing Swift code."
        }
    }

    private static func localizedBulgarianQuestion(for text: String) -> String {
        questionTranslations[text] ?? "Въпрос: \(text)"
    }

    private static func localizedBulgarianAnswer(_ answer: String) -> String {
        answerTranslations[answer] ?? answer
    }

    private static let questionTranslations: [String: String] = [
        "Which keyword creates a constant in Swift?": "Коя ключова дума създава константа в Swift?",
        "Which type stores whole numbers?": "Кой тип съхранява цели числа?",
        "How do you define a function in Swift?": "Как се дефинира функция в Swift?",
        "Which operator checks equality?": "Кой оператор проверява равенство?",
        "Which type represents true or false?": "Кой тип представя истина или лъжа?",
        "Which keyword creates a variable?": "Коя ключова дума създава променлива?",
        "What does nil mean in Swift?": "Какво означава nil в Swift?",
        "Which syntax creates an optional String?": "Кой синтаксис създава Optional String?",
        "Which collection keeps ordered values?": "Коя колекция пази подредени стойности?",
        "What keyword returns a value from a function?": "Коя ключова дума връща стойност от функция?",
        "Which protocol does a SwiftUI screen usually conform to?": "Към кой протокол обикновено се conform-ва SwiftUI екран?",
        "Which property provides the UI content of a View?": "Кое property предоставя UI съдържанието на View?",
        "Which wrapper stores local view state?": "Кой wrapper пази локално състояние на view?",
        "Which view arranges children vertically?": "Кой view подрежда елементи вертикално?",
        "Which view overlays children on top of each other?": "Кой view наслагва елементи един върху друг?",
        "Which modifier adds space inside a view?": "Кой modifier добавя вътрешно разстояние във view?",
        "Which view shows tappable text or content?": "Кой view показва съдържание, върху което може да се натисне?",
        "Which view displays SF Symbols?": "Кой view показва SF Symbols?",
        "Which modifier changes font style?": "Кой modifier променя стила на шрифта?",
        "Which view creates empty flexible space?": "Кой view създава празно гъвкаво пространство?",
        "What is Xcode used for?": "За какво се използва Xcode?",
        "What file usually launches a SwiftUI app?": "Кой файл обикновено стартира SwiftUI приложение?",
        "Where are app images commonly stored?": "Къде обикновено се съхраняват изображенията на приложението?",
        "What is a simulator?": "Какво е simulator?",
        "Which language is commonly used for modern iOS apps?": "Кой език често се използва за модерни iOS приложения?",
        "What is an app icon?": "Какво е app icon?",
        "What does build mean in Xcode?": "Какво означава build в Xcode?",
        "Which area shows compile problems?": "Коя зона показва проблеми при компилация?",
        "What is a Preview in SwiftUI?": "Какво е Preview в SwiftUI?",
        "What does UI stand for?": "Какво означава UI?",
        "Which statement runs code only when a condition is true?": "Кой statement изпълнява код само когато условието е вярно?",
        "Which loop repeats over items in a collection?": "Кой цикъл минава през елементи в колекция?",
        "What does && mean in a condition?": "Какво означава && в условие?",
        "What does || mean in a condition?": "Какво означава || в условие?",
        "Which operator means not equal?": "Кой оператор означава различно?",
        "What is an algorithm?": "Какво е алгоритъм?",
        "What happens when a loop condition never becomes false?": "Какво става, когато условието на цикъл никога не става false?",
        "Which statement chooses between multiple cases?": "Кой statement избира между множество случаи?",
        "What is debugging?": "Какво е debugging?",
        "What should a Boolean expression produce?": "Какво трябва да връща Boolean expression?",
        "What does AI stand for?": "Какво означава AI?",
        "What is machine learning?": "Какво е машинно обучение?",
        "What is a model in AI?": "Какво е модел в AI?",
        "What is training data?": "Какво са training data?",
        "What is a prompt?": "Какво е prompt?",
        "What is classification?": "Какво е classification?",
        "What is prediction?": "Какво е prediction?",
        "What is natural language?": "Какво е natural language?",
        "Why can AI make mistakes?": "Защо AI може да греши?",
        "What is responsible AI about?": "Какво означава responsible AI?"
    ]

    private static let answerTranslations: [String: String] = [
        "A condition": "Условие",
        "A trained system that makes predictions": "Обучена система, която прави прогнози",
        "A step-by-step solution": "Решение стъпка по стъпка",
        "A tool that runs apps like a device": "Инструмент, който стартира приложения като устройство",
        "Adds an element": "Добавя елемент",
        "AND": "И",
        "App struct": "App struct",
        "Array": "Array",
        "Assets.xcassets": "Assets.xcassets",
        "Bool": "Bool",
        "Button": "Button",
        "Choosing a category": "Избиране на категория",
        "Compile and prepare the app": "Компилира и подготвя приложението",
        "Constant time": "Константно време",
        "Dictionary": "Dictionary",
        "Divider": "Divider",
        "Empty array": "Празен масив",
        "Estimating an output": "Оценяване на резултат",
        "Examples used to teach a model": "Примери, използвани за обучение на модел",
        "Finding and fixing problems": "Намиране и поправяне на проблеми",
        "func greet()": "func greet()",
        "HStack": "HStack",
        "Human language like English": "Човешки език като английски",
        "Image(systemName:)": "Image(systemName:)",
        "Input given to an AI system": "Вход, подаден към AI система",
        "Int": "Int",
        "List": "List",
        "No value": "Липса на стойност",
        "OR": "ИЛИ",
        "ProgressView": "ProgressView",
        "Set": "Set",
        "Spacer": "Spacer",
        "String": "String",
        "String?": "String?",
        "Swift": "Swift",
        "Systems learning patterns from data": "Системи, които учат модели от данни",
        "true or false": "true или false",
        "User Interface": "Потребителски интерфейс",
        "Using AI safely and fairly": "Използване на AI безопасно и справедливо",
        "VStack": "VStack",
        "View": "View",
        "ZStack": "ZStack",
        "Zero": "Нула"
    ]
}
