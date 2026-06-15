//
//  QuizCategory.swift
//  Swift Quiz Academy
//

import SwiftUI

struct QuizCategory: Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
    let color: Color
    let questionsByDifficulty: [Difficulty: [QuizQuestion]]

    var totalQuestionCount: Int {
        questionsByDifficulty.values.reduce(0) { $0 + $1.count }
    }

    func questionCount(for difficulty: Difficulty) -> Int {
        questionsByDifficulty[difficulty]?.count ?? 0
    }

    func title(for language: AppLanguage) -> String {
        switch id {
        case "swift-basics":
            return language.localized("Swift основи", "Swift Basics")
        case "swiftui":
            return language.localized("SwiftUI", "SwiftUI")
        case "ios-basics":
            return language.localized("iOS основи", "iOS Basics")
        case "programming-logic":
            return language.localized("Програмна логика", "Programming Logic")
        case "ai-basics":
            return language.localized("AI основи", "AI Basics")
        case "daily-challenge":
            return language.localized("Дневно предизвикателство", "Daily Challenge")
        case "practice-mistakes":
            return language.localized("Упражнявай грешките", "Practice Mistakes")
        default:
            return title
        }
    }

    func description(for language: AppLanguage) -> String {
        switch id {
        case "swift-basics":
            return language.localized("Променливи, типове, функции и optional-и.", "Variables, types, functions and optionals.")
        case "swiftui":
            return language.localized("Views, state, modifiers и основи на layout.", "Views, state, modifiers and layout basics.")
        case "ios-basics":
            return language.localized("Приложения, екрани, assets и Apple platform идеи.", "Apps, screens, assets and Apple platform ideas.")
        case "programming-logic":
            return language.localized("Условия, цикли, сравнения и решаване на проблеми.", "Conditions, loops, comparisons and problem solving.")
        case "ai-basics":
            return language.localized("Основни понятия за модерен AI и машинно обучение.", "Core terms for modern AI and machine learning.")
        case "daily-challenge":
            return language.localized("Един специален смесен quiz на ден с bonus XP.", "One special mixed quiz per day with bonus XP.")
        case "practice-mistakes":
            return language.localized("Преговори въпросите, на които си отговорил грешно.", "Review questions you answered incorrectly.")
        default:
            return description
        }
    }

    static let dailyChallenge = QuizCategory(
        id: "daily-challenge",
        title: "Daily Challenge",
        description: "One special mixed quiz per day with bonus XP.",
        icon: "calendar.badge.clock",
        color: .orange,
        questionsByDifficulty: [
            .advanced: [
                QuizQuestion(text: "Daily Swift: Which keyword creates an immutable value?", answers: ["var", "let", "mutating", "static"], correctAnswerIndex: 1),
                QuizQuestion(text: "Daily SwiftUI: Which wrapper stores simple local state?", answers: ["@State", "@Binding", "@SceneStorage", "@Environment"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily iOS: What does a Preview help you inspect?", answers: ["The app UI", "Only network logs", "App Store reviews", "Device storage"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily Logic: What does an if statement use?", answers: ["A condition", "Only an image", "A file path", "A package name"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily AI: What is a prompt?", answers: ["Input for an AI system", "A screen size", "An app icon", "A compiler"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily Swift: Which collection stores key-value pairs?", answers: ["Array", "Set", "Dictionary", "String"], correctAnswerIndex: 2),
                QuizQuestion(text: "Daily SwiftUI: Which layout places views horizontally?", answers: ["VStack", "HStack", "ZStack", "Spacer"], correctAnswerIndex: 1),
                QuizQuestion(text: "Daily iOS: What is the simulator used for?", answers: ["Running apps like a device", "Writing emails", "Editing icons only", "Deleting code"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily Logic: What does == check?", answers: ["Equality", "Assignment", "Importing", "Looping"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily AI: Why should AI output be checked?", answers: ["It can make mistakes", "It never uses data", "It cannot answer", "It only draws UI"], correctAnswerIndex: 0)
            ]
        ]
    )

    static let allCategories: [QuizCategory] = [
        QuizCategory(
            id: "swift-basics",
            title: "Swift Basics",
            description: "Variables, types, functions and optionals.",
            icon: "swift",
            color: .orange,
            questionsByDifficulty: [
                .beginner: [
                    QuizQuestion(text: "Which keyword creates a constant in Swift?", answers: ["var", "let", "func", "class"], correctAnswerIndex: 1),
                    QuizQuestion(text: "Which type stores whole numbers?", answers: ["String", "Bool", "Int", "Double"], correctAnswerIndex: 2),
                    QuizQuestion(text: "How do you define a function in Swift?", answers: ["function greet()", "func greet()", "def greet()", "method greet()"], correctAnswerIndex: 1),
                    QuizQuestion(text: "Which operator checks equality?", answers: ["=", "==", "!=", ">="], correctAnswerIndex: 1),
                    QuizQuestion(text: "Which type represents true or false?", answers: ["Bool", "Int", "Array", "String"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which keyword creates a variable?", answers: ["let", "var", "set", "new"], correctAnswerIndex: 1),
                    QuizQuestion(text: "What does nil mean in Swift?", answers: ["Zero", "No value", "Empty array", "A string"], correctAnswerIndex: 1),
                    QuizQuestion(text: "Which syntax creates an optional String?", answers: ["String!", "String?", "Optional.String", "String.nil"], correctAnswerIndex: 1),
                    QuizQuestion(text: "Which collection keeps ordered values?", answers: ["Set", "Dictionary", "Array", "Enum"], correctAnswerIndex: 2),
                    QuizQuestion(text: "What keyword returns a value from a function?", answers: ["send", "return", "break", "yield"], correctAnswerIndex: 1)
                ],
                .intermediate: [
                    QuizQuestion(text: "What does type inference allow Swift to do?", answers: ["Guess a type from the assigned value", "Skip compilation", "Convert all values to String", "Ignore optionals"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which keyword marks a method that changes a struct property?", answers: ["static", "mutating", "override", "lazy"], correctAnswerIndex: 1),
                    QuizQuestion(text: "What does optional binding with if let do?", answers: ["Safely unwraps an optional", "Creates a loop", "Builds a class", "Sorts an array"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which collection stores unique unordered values?", answers: ["Array", "Set", "Dictionary", "Tuple"], correctAnswerIndex: 1),
                    QuizQuestion(text: "What is a tuple useful for?", answers: ["Grouping multiple values together", "Only networking", "Deleting variables", "Creating icons"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which access level keeps code usable only inside the same file?", answers: ["public", "private", "fileprivate", "open"], correctAnswerIndex: 2),
                    QuizQuestion(text: "What does guard usually help with?", answers: ["Early exit when a condition fails", "Drawing shapes", "Importing assets", "Running animations only"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which syntax defines a closure parameter?", answers: ["{ value in ... }", "func value =>", "class value", "import value"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does append do on an Array?", answers: ["Adds an element", "Removes all values", "Sorts descending", "Creates an optional"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which keyword defines a custom value type?", answers: ["struct", "package", "screen", "asset"], correctAnswerIndex: 0)
                ],
                .advanced: [
                    QuizQuestion(text: "What problem do generics solve?", answers: ["Writing reusable code for multiple types", "Avoiding all types", "Drawing views", "Skipping tests"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does associatedtype define in a protocol?", answers: ["A placeholder type chosen by conformers", "A fixed String", "An app icon", "A stored property only"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which feature helps avoid reference cycles?", answers: ["weak references", "for loops", "arrays", "tuples"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does throwing function syntax include?", answers: ["throws", "error", "catching", "failed"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does async await model?", answers: ["Asynchronous work with suspension points", "Only animations", "Only strings", "Only dictionaries"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does value semantics mean for structs?", answers: ["Copies are independent values", "All structs are global", "They cannot have methods", "They are always optional"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is protocol-oriented programming?", answers: ["Designing around protocols and conformances", "Only using classes", "Avoiding extensions", "Writing no types"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What can extensions add?", answers: ["Methods, computed properties, and conformances", "Stored properties always", "New app targets", "Only comments"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does defer do?", answers: ["Runs code when leaving scope", "Starts a task immediately", "Deletes memory", "Creates a class"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does Result<Success, Failure> represent?", answers: ["Success or failure as a value", "Only an integer", "A SwiftUI layout", "An asset catalog"], correctAnswerIndex: 0)
                ]
            ]
        ),
        QuizCategory(
            id: "swiftui",
            title: "SwiftUI",
            description: "Views, state, modifiers and layout basics.",
            icon: "square.stack.3d.up.fill",
            color: .blue,
            questionsByDifficulty: [
                .beginner: [
                    QuizQuestion(text: "Which protocol does a SwiftUI screen usually conform to?", answers: ["View", "Scene", "App", "Model"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which property provides the UI content of a View?", answers: ["layout", "body", "screen", "render"], correctAnswerIndex: 1),
                    QuizQuestion(text: "Which wrapper stores local view state?", answers: ["@State", "@Local", "@View", "@Store"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which view arranges children vertically?", answers: ["HStack", "VStack", "ZStack", "List"], correctAnswerIndex: 1),
                    QuizQuestion(text: "Which view overlays children on top of each other?", answers: ["Grid", "HStack", "ZStack", "Form"], correctAnswerIndex: 2),
                    QuizQuestion(text: "Which modifier adds space inside a view?", answers: ["padding()", "border()", "clipShape()", "offset()"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which view shows tappable text or content?", answers: ["Button", "Text", "Image", "Spacer"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which view displays SF Symbols?", answers: ["Text", "Image(systemName:)", "SymbolView", "Icon"], correctAnswerIndex: 1),
                    QuizQuestion(text: "Which modifier changes font style?", answers: [".font()", ".tint()", ".task()", ".tag()"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which view creates empty flexible space?", answers: ["Divider", "Spacer", "Group", "Section"], correctAnswerIndex: 1)
                ],
                .intermediate: [
                    QuizQuestion(text: "What does @Binding allow a child view to do?", answers: ["Read and write state owned elsewhere", "Create a database", "Disable previews", "Import images"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which modifier changes a view's foreground color/style?", answers: ["foregroundStyle", "padding", "task", "tag"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is the purpose of NavigationStack?", answers: ["Managing navigation paths", "Storing passwords", "Drawing charts only", "Compiling assets"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which container efficiently shows rows of data?", answers: ["List", "Circle", "Image", "Spacer"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does .sheet present?", answers: ["A modal view", "A new compiler", "An image asset", "A unit test"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which wrapper reads system values like color scheme?", answers: ["@Environment", "@State", "@Main", "@Local"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does ForEach need for dynamic data?", answers: ["Identifiable data or an id", "Only images", "A timer", "A database"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which modifier clips a view to a shape?", answers: ["clipShape", "font", "task", "tag"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does .disabled(true) do?", answers: ["Prevents interaction", "Deletes a view", "Changes app icon", "Starts navigation"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which view draws a progress indicator?", answers: ["ProgressView", "Spacer", "Section", "Group"], correctAnswerIndex: 0)
                ],
                .advanced: [
                    QuizQuestion(text: "Why should view body stay lightweight?", answers: ["It can be recomputed often", "It runs only once ever", "It stores databases", "It signs apps"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does identity affect in SwiftUI lists?", answers: ["Diffing, updates, and animations", "Only colors", "Only network calls", "Only app icons"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does @StateObject preserve?", answers: ["An observable object owned by the view", "A local Int only", "A static color", "A system image"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does @ObservedObject imply?", answers: ["The object is owned elsewhere", "The view owns it permanently", "It is a constant", "It is not observable"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does PreferenceKey help pass?", answers: ["Child view values upward", "Passwords", "Assets", "Build settings"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a custom Layout used for?", answers: ["Defining measurement and placement", "Saving UserDefaults", "Creating tests", "Signing apps"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does transaction control?", answers: ["Animation details for state changes", "Database rows", "App target names", "Image compression"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What can matchedGeometryEffect create?", answers: ["Smooth transitions between related views", "Network requests", "Compile errors", "User accounts"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Why avoid heavy work directly in body?", answers: ["It can hurt rendering performance", "Body never reruns", "It disables buttons", "It deletes state"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does EquatableView help with?", answers: ["Skipping unchanged view updates", "Sorting arrays", "Signing builds", "Drawing icons"], correctAnswerIndex: 0)
                ]
            ]
        ),
        QuizCategory(
            id: "ios-basics",
            title: "iOS Basics",
            description: "Apps, screens, assets and Apple platform ideas.",
            icon: "iphone.gen3",
            color: .green,
            questionsByDifficulty: [
                .beginner: [
                    QuizQuestion(text: "What is Xcode used for?", answers: ["Editing photos", "Building Apple apps", "Managing passwords", "Browsing files only"], correctAnswerIndex: 1),
                    QuizQuestion(text: "What file usually launches a SwiftUI app?", answers: ["App struct", "README", "Asset catalog", "Preview"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Where are app images commonly stored?", answers: ["Assets.xcassets", "Tests", "Products", "Derived Data only"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a simulator?", answers: ["A fake API", "A tool that runs apps like a device", "A compiler error", "A cloud database"], correctAnswerIndex: 1),
                    QuizQuestion(text: "Which language is commonly used for modern iOS apps?", answers: ["Swift", "PHP", "SQL", "HTML only"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is an app icon?", answers: ["The launch image shown on the Home Screen", "A unit test", "A data type", "A network call"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does build mean in Xcode?", answers: ["Compile and prepare the app", "Delete the app", "Change the language", "Open Safari"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which area shows compile problems?", answers: ["Issue Navigator", "Color Picker", "Calendar", "Photos"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a Preview in SwiftUI?", answers: ["A live UI render in Xcode", "A database", "A file format", "A keyboard shortcut"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does UI stand for?", answers: ["User Interface", "Universal Internet", "Unit Index", "Upload Item"], correctAnswerIndex: 0)
                ],
                .intermediate: [
                    QuizQuestion(text: "What is a bundle identifier used for?", answers: ["Uniquely identifying an app", "Changing font size", "Making loops", "Sorting arrays"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does Info.plist commonly store?", answers: ["App configuration metadata", "Only quiz answers", "Swift functions", "Compiled binaries"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is the App lifecycle about?", answers: ["How an app starts, runs, and stops", "Only icons", "Only tests", "Only colors"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does provisioning relate to?", answers: ["Signing and running apps on devices", "Creating arrays", "Changing text", "Writing loops"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which framework is used for notifications?", answers: ["UserNotifications", "MapKit", "SwiftUI", "Foundation only"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is sandboxing on iOS?", answers: ["Apps have isolated storage and permissions", "Apps can edit all files", "Apps skip signing", "Apps cannot store data"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is TestFlight used for?", answers: ["Beta testing apps", "Drawing views", "Writing functions", "Making assets"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does localization support?", answers: ["Multiple languages and regions", "Only dark mode", "Only network calls", "Only previews"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a target in Xcode?", answers: ["A build product configuration", "A Swift loop", "A button style", "A color asset"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is an entitlement?", answers: ["A permission/capability for app services", "A question type", "A view modifier", "A number type"], correctAnswerIndex: 0)
                ],
                .advanced: [
                    QuizQuestion(text: "What does code signing prove?", answers: ["The app comes from an identified developer", "The UI is blue", "The app has no bugs", "The app uses SwiftUI"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is background execution limited by?", answers: ["System policies and capabilities", "Only array length", "Only font size", "Only app name"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Why request permissions at runtime?", answers: ["To get user consent for protected data", "To compile faster", "To create structs", "To draw gradients"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does Keychain store best?", answers: ["Sensitive credentials", "Large videos", "All source files", "Preview code"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does App Transport Security encourage?", answers: ["Secure network connections", "More animations", "Bigger icons", "No optionals"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a deep link?", answers: ["A link that opens a specific app location", "A nested loop", "A large image", "A compiler feature"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is memory pressure?", answers: ["The system needs apps to reduce memory use", "A syntax error", "A missing icon", "A type mismatch only"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does Instruments help analyze?", answers: ["Performance and resource usage", "Only quiz text", "Only colors", "Only localization"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is accessibility support for?", answers: ["Making apps usable by more people", "Hiding UI", "Skipping tests", "Reducing all text"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does universal link use?", answers: ["Associated domains to open app content", "Only local variables", "Only previews", "Only SF Symbols"], correctAnswerIndex: 0)
                ]
            ]
        ),
        QuizCategory(
            id: "programming-logic",
            title: "Programming Logic",
            description: "Conditions, loops, comparisons and problem solving.",
            icon: "brain.head.profile",
            color: .purple,
            questionsByDifficulty: [
                .beginner: [
                    QuizQuestion(text: "Which statement runs code only when a condition is true?", answers: ["if", "let", "import", "return"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which loop repeats over items in a collection?", answers: ["for-in", "switch", "guard", "struct"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does && mean in a condition?", answers: ["AND", "OR", "NOT", "EQUAL"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does || mean in a condition?", answers: ["AND", "OR", "LESS", "PLUS"], correctAnswerIndex: 1),
                    QuizQuestion(text: "Which operator means not equal?", answers: ["==", "!=", "<=", "="], correctAnswerIndex: 1),
                    QuizQuestion(text: "What is an algorithm?", answers: ["A step-by-step solution", "A color", "A device", "A random number"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What happens when a loop condition never becomes false?", answers: ["Infinite loop", "Optional", "Compilation", "Import"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which statement chooses between multiple cases?", answers: ["switch", "var", "Text", "Array"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is debugging?", answers: ["Finding and fixing problems", "Adding icons", "Publishing instantly", "Changing font size only"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What should a Boolean expression produce?", answers: ["true or false", "Only text", "Only images", "A file"], correctAnswerIndex: 0)
                ],
                .intermediate: [
                    QuizQuestion(text: "What does decomposition mean?", answers: ["Breaking a problem into smaller parts", "Deleting code", "Changing colors", "Compiling twice"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a variable's scope?", answers: ["Where it can be accessed", "Its color", "Its icon", "Its device"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does short-circuit evaluation do?", answers: ["Stops checking once the result is known", "Deletes all conditions", "Runs every branch", "Skips compilation"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which data structure works first-in, first-out?", answers: ["Queue", "Stack", "Set", "Tree"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Which data structure works last-in, first-out?", answers: ["Stack", "Queue", "Array only", "Dictionary"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a base case in recursion?", answers: ["The condition that stops recursion", "The largest array", "The app icon", "A Boolean operator"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does sorting do?", answers: ["Arranges values by a rule", "Deletes values", "Creates UI", "Imports modules"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a precondition?", answers: ["Something expected to be true before code runs", "A font", "An asset", "A device"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does modulo (%) return?", answers: ["The remainder", "The quotient", "A string", "A Boolean only"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is an edge case?", answers: ["An unusual input that may break logic", "A screen edge", "A color", "A package"], correctAnswerIndex: 0)
                ],
                .advanced: [
                    QuizQuestion(text: "What is Big O notation used for?", answers: ["Describing algorithm growth", "Drawing circles", "Naming variables", "Signing apps"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does O(1) mean?", answers: ["Constant time", "Linear time", "Exponential time", "No time"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does binary search require?", answers: ["Sorted data", "Random data", "Images", "A network"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a graph made of?", answers: ["Nodes and edges", "Only arrays", "Only strings", "Only views"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is dynamic programming often used for?", answers: ["Reusing overlapping subproblem results", "Changing icons", "Importing packages", "Writing comments"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does immutability help reduce?", answers: ["Unexpected state changes", "All memory use", "All UI code", "All functions"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a race condition?", answers: ["Output depends on timing of operations", "A fast loop only", "A sorting rule", "A compiler setting"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is memoization?", answers: ["Caching previous results", "Deleting previous results", "Drawing tables", "Changing text"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does idempotent mean?", answers: ["Repeated calls have the same effect", "Calls always fail", "Calls are random", "Calls require UI"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a state machine?", answers: ["A model with states and transitions", "A hardware-only feature", "A font system", "An image type"], correctAnswerIndex: 0)
                ]
            ]
        ),
        QuizCategory(
            id: "ai-basics",
            title: "AI Basics",
            description: "Core terms for modern AI and machine learning.",
            icon: "sparkles",
            color: .pink,
            questionsByDifficulty: [
                .beginner: [
                    QuizQuestion(text: "What does AI stand for?", answers: ["Artificial Intelligence", "Apple Interface", "Automatic Internet", "App Installer"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is machine learning?", answers: ["Systems learning patterns from data", "Manual typing only", "A phone setting", "A design color"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a model in AI?", answers: ["A trained system that makes predictions", "A button", "A screen layout", "A cable"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is training data?", answers: ["Examples used to teach a model", "A workout app", "A font", "A folder name"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a prompt?", answers: ["Input given to an AI system", "A compiler", "A battery type", "An icon"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is classification?", answers: ["Choosing a category", "Drawing a line", "Opening settings", "Saving a password"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is prediction?", answers: ["Estimating an output", "Deleting files", "Changing language", "Drawing UI only"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is natural language?", answers: ["Human language like English", "Only Swift code", "Binary numbers", "A device model"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Why can AI make mistakes?", answers: ["It predicts from patterns", "It never uses data", "It has no output", "It cannot receive input"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is responsible AI about?", answers: ["Using AI safely and fairly", "Making screens blue", "Writing fewer tests", "Ignoring users"], correctAnswerIndex: 0)
                ],
                .intermediate: [
                    QuizQuestion(text: "What is overfitting?", answers: ["A model memorizes training data too closely", "A perfect model", "A UI bug", "A battery issue"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is inference in AI?", answers: ["Using a trained model to produce output", "Deleting training data", "Opening Xcode", "Creating icons"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a token in language models?", answers: ["A chunk of text", "A device", "A Swift keyword only", "An image file"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is bias in data?", answers: ["Skew that can affect model behavior", "A button", "A compiler warning", "A network port"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is validation data used for?", answers: ["Checking model performance during development", "Drawing UI", "Signing apps", "Changing fonts"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a neural network inspired by?", answers: ["Connected processing units", "App icons", "File folders", "Screen pixels only"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is embeddings used for?", answers: ["Representing meaning as numbers", "Creating iOS certificates", "Deleting arrays", "Making buttons"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is hallucination in AI?", answers: ["A confident but incorrect output", "A guaranteed fact", "A UI animation", "A file format"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is supervised learning?", answers: ["Learning from labeled examples", "Learning with no data", "Manual UI layout", "App Store review"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a confidence score?", answers: ["How sure a model is about output", "A view size", "An icon name", "A Swift loop"], correctAnswerIndex: 0)
                ],
                .advanced: [
                    QuizQuestion(text: "What is temperature in text generation?", answers: ["A control for randomness", "A hardware sensor only", "A data label", "A model size"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is retrieval augmented generation?", answers: ["Using retrieved context to answer", "Training with no data", "Only drawing UI", "Deleting prompts"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What does fine-tuning usually change?", answers: ["Model behavior using additional training", "The app icon", "The screen size", "The compiler"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is a confusion matrix useful for?", answers: ["Evaluating classification results", "Designing colors", "Signing apps", "Creating arrays"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is precision?", answers: ["How many predicted positives were correct", "How many files compile", "How fast UI draws", "How large an icon is"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is recall?", answers: ["How many actual positives were found", "How many buttons exist", "How many files import SwiftUI", "How many views animate"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is context window?", answers: ["How much input a model can consider", "The app's main window", "A SwiftUI modifier", "A screen brightness value"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is model evaluation?", answers: ["Measuring output quality against criteria", "Changing fonts", "Opening a simulator", "Creating assets"], correctAnswerIndex: 0),
                    QuizQuestion(text: "What is prompt injection?", answers: ["Input that tries to override instructions", "A Swift function", "A layout container", "A memory warning"], correctAnswerIndex: 0),
                    QuizQuestion(text: "Why use human review for high-risk AI output?", answers: ["To reduce harm from mistakes", "To slow all apps", "To avoid UI", "To remove data"], correctAnswerIndex: 0)
                ]
            ]
        )
    ]
}
