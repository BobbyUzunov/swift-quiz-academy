export default [
  {
    beginner: {
      questionEN: "A screen fetches invoices and formats totals. Which part should format and expose display state?",
      questionBG: "Екран зарежда фактури и форматира суми. Коя част трябва да подготви състоянието за показване?",
      answersEN: [
        "ViewModel",
        "UIView",
        "Repository",
        "Coordinator"
      ],
      answersBG: [
        "ViewModel",
        "UIView",
        "Repository",
        "Coordinator"
      ],
      correctEN: "ViewModel",
      correctBG: "ViewModel",
      explanationEN: "The ViewModel converts domain data into presentation-ready values while the View focuses on rendering.",
      explanationBG: "ViewModel преобразува домейн данните в стойности за показване, а View се грижи само за визуализацията."
    },
    intermediate: {
      questionEN: "A ticket list flickers because formatting runs inside cells repeatedly. What MVVM fix helps most?",
      questionBG: "Списък с тикети премигва, защото форматирането се случва многократно в клетките. Кой MVVM fix помага най-много?",
      answersEN: [
        "Precompute display models in ViewModel",
        "Add more Auto Layout constraints",
        "Move formatting to storyboard",
        "Use static UITableViewCells"
      ],
      answersBG: [
        "Предварителни display модели във ViewModel",
        "Още Auto Layout ограничения",
        "Форматиране в storyboard",
        "Static UITableViewCells"
      ],
      correctEN: "Precompute display models in ViewModel",
      correctBG: "Предварителни display модели във ViewModel",
      explanationEN: "Moving formatting to ViewModel avoids repeated heavy UI-layer work and stabilizes rendering performance.",
      explanationBG: "Когато форматирането е във ViewModel, се избягва тежка повтаряема работа в UI слоя и рендерирането става по-стабилно."
    },
    advanced: {
      questionEN: "Three teams implement the same price formatting differently across modules. What architecture guard prevents drift?",
      questionBG: "Три екипа форматират цените различно в различни модули. Коя архитектурна защита спира този drift?",
      answersEN: [
        "Shared presentation mapper contracts",
        "Copy-paste formatting per screen",
        "Let each View decide",
        "Store formatted text in DB"
      ],
      answersBG: [
        "Споделени договори за presentation mapper",
        "Copy-paste форматиране на всеки екран",
        "Всеки View да решава сам",
        "Запис на форматиран текст в DB"
      ],
      correctEN: "Shared presentation mapper contracts",
      correctBG: "Споделени договори за presentation mapper",
      explanationEN: "Shared mapper contracts enforce consistent representation and make regressions detectable in tests.",
      explanationBG: "Споделените mapper договори налагат еднакво представяне и позволяват откриване на регресии чрез тестове."
    }
  },
  {
    beginner: {
      questionEN: "A child view needs to toggle a parent-owned switch state. What binding style fits MVVM best?",
      questionBG: "Дъщерен изглед трябва да превключи switch състояние, притежавано от родителя. Кой binding стил е най-подходящ?",
      answersEN: [
        "Expose intent callback to ViewModel",
        "Directly mutate model singleton",
        "Write to UserDefaults from child",
        "Use NotificationCenter everywhere"
      ],
      answersBG: [
        "Intent callback към ViewModel",
        "Директна промяна на model singleton",
        "Запис в UserDefaults от child",
        "NotificationCenter за всичко"
      ],
      correctEN: "Expose intent callback to ViewModel",
      correctBG: "Intent callback към ViewModel",
      explanationEN: "Intent callbacks keep ownership clear and route mutations through the ViewModel.",
      explanationBG: "Intent callback-ите пазят ясна собственост и насочват промените през ViewModel."
    },
    intermediate: {
      questionEN: "User taps retry quickly five times and sends five requests. What ViewModel safeguard should be added?",
      questionBG: "Потребител натиска retry пет пъти бързо и тръгват пет заявки. Каква защита трябва да се добави във ViewModel?",
      answersEN: [
        "In-flight request deduplication",
        "More loading spinners",
        "Disable network layer logs",
        "Increase timeout"
      ],
      answersBG: [
        "Deduplication на in-flight заявки",
        "Повече loading индикатори",
        "Спиране на network логовете",
        "Увеличаване на timeout"
      ],
      correctEN: "In-flight request deduplication",
      correctBG: "Deduplication на in-flight заявки",
      explanationEN: "Deduplication ensures repeated intents do not create duplicate side effects.",
      explanationBG: "Deduplication гарантира, че повторни намерения не създават дублирани странични ефекти."
    },
    advanced: {
      questionEN: "A payment ViewModel must support cancel/retry/resume across app lifecycle transitions. Which model scales?",
      questionBG: "Payment ViewModel трябва да поддържа cancel/retry/resume през lifecycle преходи. Кой модел скалира?",
      answersEN: [
        "Event-driven state machine",
        "Boolean flags scattered in view",
        "One gigantic method",
        "Manual timers in controller"
      ],
      answersBG: [
        "Event-driven state machine",
        "Разпръснати boolean флагове във view",
        "Един огромен метод",
        "Ръчни таймери в контролера"
      ],
      correctEN: "Event-driven state machine",
      correctBG: "Event-driven state machine",
      explanationEN: "State machines make transitions explicit and resilient under interruption-heavy flows.",
      explanationBG: "State machine прави преходите явни и устойчиви при чести прекъсвания."
    }
  },
  {
    beginner: {
      questionEN: "A ViewModel creates URLSession directly, making tests hard. What DI approach is simplest?",
      questionBG: "ViewModel създава URLSession директно и тестовете са трудни. Кой DI подход е най-прост?",
      answersEN: [
        "Initializer injection with protocol dependency",
        "Global static networking manager",
        "Reflection-based service locator",
        "Hardcoded mock switch"
      ],
      answersBG: [
        "Initializer injection с protocol зависимост",
        "Глобален static networking manager",
        "Service locator чрез reflection",
        "Твърдо кодиран mock switch"
      ],
      correctEN: "Initializer injection with protocol dependency",
      correctBG: "Initializer injection с protocol зависимост",
      explanationEN: "Initializer injection makes dependencies explicit and replaceable in tests.",
      explanationBG: "Initializer injection прави зависимостите явни и лесни за подмяна в тестове."
    },
    intermediate: {
      questionEN: "Different feature modules register services differently and runtime crashes appear. What prevents this?",
      questionBG: "Различни feature модули регистрират услуги по различен начин и има runtime сривове. Какво ги предотвратява?",
      answersEN: [
        "Composition root per app entrypoint",
        "Register dependencies lazily in random screens",
        "Resolve services in table cells",
        "Duplicate registrations per module"
      ],
      answersBG: [
        "Composition root за всеки app entrypoint",
        "Lazy регистрация в произволни екрани",
        "Resolve на услуги в table cells",
        "Дублирани регистрации по модули"
      ],
      correctEN: "Composition root per app entrypoint",
      correctBG: "Composition root за всеки app entrypoint",
      explanationEN: "A composition root centralizes wiring and catches missing registrations early.",
      explanationBG: "Composition root централизира свързването и хваща липсващи регистрации рано."
    },
    advanced: {
      questionEN: "You need deterministic DI across app extensions, widgets, and main app. What is robust?",
      questionBG: "Трябва детерминиран DI за app extensions, widgets и основното приложение. Кое е устойчиво?",
      answersEN: [
        "Scoped containers with explicit lifetime rules",
        "One mutable singleton graph",
        "Runtime type-name lookup strings",
        "Manual optional unwrapping everywhere"
      ],
      answersBG: [
        "Scoped контейнери с ясни lifetime правила",
        "Един mutable singleton graph",
        "Runtime lookup по type-name низове",
        "Ръчно optional unwrapping навсякъде"
      ],
      correctEN: "Scoped containers with explicit lifetime rules",
      correctBG: "Scoped контейнери с ясни lifetime правила",
      explanationEN: "Scoped lifetimes prevent leaks and cross-target coupling while preserving predictable construction.",
      explanationBG: "Scoped lifetime-ите предотвратяват течове и смесване между target-и, като пазят предвидима конструкция."
    }
  },
  {
    beginner: {
      questionEN: "A ViewModel reads API and cache directly. What pattern isolates data source details?",
      questionBG: "ViewModel чете директно от API и кеш. Кой pattern изолира детайлите на източниците?",
      answersEN: [
        "Repository abstraction",
        "Coordinator pattern",
        "Factory for UILabel",
        "SceneDelegate switch"
      ],
      answersBG: [
        "Repository абстракция",
        "Coordinator pattern",
        "Factory за UILabel",
        "SceneDelegate switch"
      ],
      correctEN: "Repository abstraction",
      correctBG: "Repository абстракция",
      explanationEN: "Repositories hide data source specifics and offer a stable contract to ViewModels.",
      explanationBG: "Repository слой скрива детайлите на източниците и дава стабилен договор към ViewModel."
    },
    intermediate: {
      questionEN: "Offline cache returns stale profile while server has newer data. What repository policy is better?",
      questionBG: "Офлайн кеш връща стар профил, а сървърът има нов. Коя repository политика е по-добра?",
      answersEN: [
        "Stale-while-revalidate strategy",
        "Always cache forever",
        "Never cache anything",
        "Reload only on app reinstall"
      ],
      answersBG: [
        "Stale-while-revalidate стратегия",
        "Вечен cache",
        "Никога без кеш",
        "Reload само при преинсталация"
      ],
      correctEN: "Stale-while-revalidate strategy",
      correctBG: "Stale-while-revalidate стратегия",
      explanationEN: "SWR serves fast data first and refreshes in background for freshness.",
      explanationBG: "SWR връща бързо наличните данни и паралелно ги обновява за актуалност."
    },
    advanced: {
      questionEN: "Concurrent sync jobs create merge conflicts in local and remote stores. What repository capability is required?",
      questionBG: "Паралелни sync задачи създават merge конфликти в локално и remote хранилище. Каква repository способност е нужна?",
      answersEN: [
        "Conflict resolution rules with deterministic precedence",
        "Last write wins blindly",
        "Disable background sync",
        "Keep separate duplicate records"
      ],
      answersBG: [
        "Conflict resolution правила с детерминиран приоритет",
        "Сляпо last write wins",
        "Спиране на background sync",
        "Пазене на дублирани записи"
      ],
      correctEN: "Conflict resolution rules with deterministic precedence",
      correctBG: "Conflict resolution правила с детерминиран приоритет",
      explanationEN: "Deterministic conflict policies keep state consistent across retries and concurrent updates.",
      explanationBG: "Детерминираните правила за конфликт пазят състоянието консистентно при retry и конкурентни обновявания."
    }
  },
  {
    beginner: {
      questionEN: "A login screen has business validation logic in ViewController. Where should it move in MVVM?",
      questionBG: "Login екран има бизнес валидация във ViewController. Къде трябва да се премести в MVVM?",
      answersEN: [
        "ViewModel",
        "Storyboard constraints",
        "AppDelegate",
        "UITableViewDataSource"
      ],
      answersBG: [
        "ViewModel",
        "Storyboard constraints",
        "AppDelegate",
        "UITableViewDataSource"
      ],
      correctEN: "ViewModel",
      correctBG: "ViewModel",
      explanationEN: "Validation rules are presentation/business logic and belong in the ViewModel.",
      explanationBG: "Валидационните правила са presentation/business логика и принадлежат на ViewModel."
    },
    intermediate: {
      questionEN: "Multiple ViewModels duplicate the same email validation. What design improves reuse?",
      questionBG: "Няколко ViewModel-а дублират една и съща email валидация. Кой дизайн подобрява повторната употреба?",
      answersEN: [
        "Extract validator service injected into ViewModels",
        "Copy validation into each view",
        "Validate only on backend",
        "Store regex in storyboard"
      ],
      answersBG: [
        "Изнеси validator услуга, инжектирана във ViewModel-ите",
        "Копирай валидацията във всеки view",
        "Валидация само на backend",
        "Regex в storyboard"
      ],
      correctEN: "Extract validator service injected into ViewModels",
      correctBG: "Изнеси validator услуга, инжектирана във ViewModel-ите",
      explanationEN: "Shared validator services remove duplication and keep rule changes centralized.",
      explanationBG: "Споделените validator услуги премахват дублирането и централизират промените по правилата."
    },
    advanced: {
      questionEN: "Validation depends on country-specific legal rules updated monthly. What architecture supports this safely?",
      questionBG: "Валидацията зависи от държавни правни правила, обновявани ежемесечно. Коя архитектура поддържа това безопасно?",
      answersEN: [
        "Policy engine + versioned rule provider",
        "Hardcoded if-else per country",
        "App restart to refresh constants",
        "Manual QA edits in release"
      ],
      answersBG: [
        "Policy engine + versioned rule provider",
        "Твърди if-else за всяка държава",
        "Рестарт за refresh на константите",
        "Ръчни QA редакции в release"
      ],
      correctEN: "Policy engine + versioned rule provider",
      correctBG: "Policy engine + versioned rule provider",
      explanationEN: "Versioned policy providers allow controlled legal updates without rewriting every ViewModel.",
      explanationBG: "Versioned policy provider-ите позволяват контролирани правни обновления без пренаписване на всеки ViewModel."
    }
  },
  {
    beginner: {
      questionEN: "A screen displays loading, content, and error using three booleans that conflict. What model is cleaner?",
      questionBG: "Екран показва loading, content и error с три boolean флага, които се бият. Кой модел е по-чист?",
      answersEN: [
        "Single enum screen state",
        "Five more booleans",
        "Hidden UILabel flags",
        "State in navigation title"
      ],
      answersBG: [
        "Един enum за screen state",
        "Още пет boolean-а",
        "Скрити UILabel флагове",
        "Състояние в navigation title"
      ],
      correctEN: "Single enum screen state",
      correctBG: "Един enum за screen state",
      explanationEN: "An enum makes invalid combinations impossible and simplifies UI rendering logic.",
      explanationBG: "Enum моделът прави невалидните комбинации невъзможни и опростява логиката за рендериране."
    },
    intermediate: {
      questionEN: "Error state persists after successful retry because state mutation is partial. What fix is best?",
      questionBG: "Error състоянието остава след успешен retry, защото мутацията е частична. Кой fix е най-добър?",
      answersEN: [
        "Replace whole state atomically",
        "Patch single label text",
        "Ignore stale error visually",
        "Add another error flag"
      ],
      answersBG: [
        "Атомарна замяна на цялото състояние",
        "Промяна само на един label",
        "Визуално игнориране на старата грешка",
        "Добавяне на още един error флаг"
      ],
      correctEN: "Replace whole state atomically",
      correctBG: "Атомарна замяна на цялото състояние",
      explanationEN: "Atomic state replacement prevents half-updated UI and stale fragments.",
      explanationBG: "Атомарната смяна на state-а предотвратява полуобновен UI и остатъчни стари стойности."
    },
    advanced: {
      questionEN: "You need reproducible bug reports for state glitches in production. What addition is valuable?",
      questionBG: "Трябват възпроизводими bug reports за state проблеми в production. Какво е ценно да се добави?",
      answersEN: [
        "State transition logging with event IDs",
        "Only screenshots from support",
        "Random console print statements",
        "Disable retries globally"
      ],
      answersBG: [
        "Лог на state преходите с event ID",
        "Само screenshot-и от support",
        "Случайни console print-ове",
        "Глобално спиране на retry"
      ],
      correctEN: "State transition logging with event IDs",
      correctBG: "Лог на state преходите с event ID",
      explanationEN: "Transition logs reconstruct how the app reached a bad state, enabling targeted fixes.",
      explanationBG: "Логът на преходите показва как приложението е стигнало до дефектно състояние и позволява целенасочен fix."
    }
  },
  {
    beginner: {
      questionEN: "A ViewModel updates published state from a background thread and UI warnings appear. What annotation helps?",
      questionBG: "ViewModel обновява published state от background thread и има UI предупреждения. Коя анотация помага?",
      answersEN: [
        "@MainActor on ViewModel/state mutations",
        "@objc dynamic on all vars",
        "@discardableResult",
        "@autoclosure"
      ],
      answersBG: [
        "@MainActor за ViewModel/state мутациите",
        "@objc dynamic за всички променливи",
        "@discardableResult",
        "@autoclosure"
      ],
      correctEN: "@MainActor on ViewModel/state mutations",
      correctBG: "@MainActor за ViewModel/state мутациите",
      explanationEN: "UI-observed state should mutate on main actor to preserve thread safety and determinism.",
      explanationBG: "Състояние, наблюдавано от UI, трябва да се променя на main actor за нишкова безопасност и предвидимост."
    },
    intermediate: {
      questionEN: "Two async tasks race and older response overwrites newer state. What pattern avoids stale wins?",
      questionBG: "Две async задачи се състезават и по-старият отговор презаписва новия state. Кой pattern го избягва?",
      answersEN: [
        "Request token/version check before commit",
        "Always commit last completed task",
        "Disable async usage",
        "Use sleep before state update"
      ],
      answersBG: [
        "Проверка на request token/version преди commit",
        "Винаги commit на последно приключилата задача",
        "Пълно спиране на async",
        "sleep преди update"
      ],
      correctEN: "Request token/version check before commit",
      correctBG: "Проверка на request token/version преди commit",
      explanationEN: "Version guards ensure only relevant responses mutate current state.",
      explanationBG: "Version guard-овете гарантират, че само актуалните отговори променят текущото състояние."
    },
    advanced: {
      questionEN: "A feed ViewModel must combine live socket updates and pagination without state corruption. Which approach is robust?",
      questionBG: "Feed ViewModel трябва да комбинира live socket обновления и pagination без corruption на state. Кой подход е устойчив?",
      answersEN: [
        "Reducer with ordered event queue",
        "Direct array mutation from each callback",
        "Separate unsynced arrays",
        "Reset list on every socket event"
      ],
      answersBG: [
        "Reducer с подредена event опашка",
        "Директна мутация от всеки callback",
        "Отделни несинхронизирани масиви",
        "Reset на списъка при всяко socket събитие"
      ],
      correctEN: "Reducer with ordered event queue",
      correctBG: "Reducer с подредена event опашка",
      explanationEN: "Ordered event processing gives deterministic merges across multiple asynchronous sources.",
      explanationBG: "Подредената обработка на събития дава детерминирани merge операции между няколко асинхронни източника."
    }
  },
  {
    beginner: {
      questionEN: "Navigation logic in ViewModel imports UIKit types. What boundary should be enforced?",
      questionBG: "Навигационната логика във ViewModel импортва UIKit типове. Коя граница трябва да се наложи?",
      answersEN: [
        "Emit abstract route intents, handle UIKit in coordinator",
        "Keep UIKit in all layers",
        "Move routes to repository",
        "Use storyboard IDs as business rules"
      ],
      answersBG: [
        "Абстрактни route intents, UIKit в coordinator",
        "UIKit във всички слоеве",
        "Маршрути в repository",
        "Storyboard ID като бизнес правило"
      ],
      correctEN: "Emit abstract route intents, handle UIKit in coordinator",
      correctBG: "Абстрактни route intents, UIKit в coordinator",
      explanationEN: "Abstract routes preserve testability and keep ViewModel framework-agnostic.",
      explanationBG: "Абстрактните маршрути пазят тестируемостта и държат ViewModel независим от UI framework."
    },
    intermediate: {
      questionEN: "Back navigation behaves differently for deep link and normal flow. What coordination fix is needed?",
      questionBG: "Back навигацията е различна при deep link и нормален поток. Каква coordinator корекция е нужна?",
      answersEN: [
        "Single navigation graph with entry context",
        "Separate manual stacks per entry",
        "Always pop to root",
        "Disable deep links"
      ],
      answersBG: [
        "Един навигационен граф с entry контекст",
        "Отделни ръчни стекове за всеки вход",
        "Винаги pop до root",
        "Изключване на deep links"
      ],
      correctEN: "Single navigation graph with entry context",
      correctBG: "Един навигационен граф с entry контекст",
      explanationEN: "A unified graph handles varied entry points while preserving coherent back behavior.",
      explanationBG: "Единният граф управлява различни входове и запазва последователно back поведение."
    },
    advanced: {
      questionEN: "App supports multi-scene and each scene needs independent flow state. What coordinator topology works?",
      questionBG: "Приложението поддържа multi-scene и всяка scene иска независим flow state. Коя coordinator топология работи?",
      answersEN: [
        "Root app coordinator with scene child coordinators",
        "One global singleton coordinator",
        "Coordinator per view cell",
        "No coordinator, only segues"
      ],
      answersBG: [
        "Root app coordinator със scene child coordinator-и",
        "Един глобален singleton coordinator",
        "Coordinator за всяка клетка",
        "Без coordinator, само segues"
      ],
      correctEN: "Root app coordinator with scene child coordinators",
      correctBG: "Root app coordinator със scene child coordinator-и",
      explanationEN: "Scene child coordinators isolate navigation context per window while sharing app-level services.",
      explanationBG: "Scene child coordinator-ите изолират навигационния контекст за всеки прозорец и споделят само app-level услуги."
    }
  },
  {
    beginner: {
      questionEN: "Unit tests for ViewModel are flaky because real network is used. What should be mocked first?",
      questionBG: "Unit тестовете за ViewModel са flaky, защото ползват реална мрежа. Какво трябва да се mock-не първо?",
      answersEN: [
        "Repository/service dependency",
        "UILabel",
        "Navigation bar title",
        "Auto Layout engine"
      ],
      answersBG: [
        "Repository/service зависимост",
        "UILabel",
        "Navigation bar title",
        "Auto Layout engine"
      ],
      correctEN: "Repository/service dependency",
      correctBG: "Repository/service зависимост",
      explanationEN: "Mocking data dependencies removes nondeterministic I/O from unit tests.",
      explanationBG: "Mock на data зависимостите маха недетерминирания I/O от unit тестовете."
    },
    intermediate: {
      questionEN: "Async ViewModel tests sometimes pass before state updates complete. What test control fixes this?",
      questionBG: "Async ViewModel тестовете понякога минават преди да приключат state обновяванията. Какъв контрол решава това?",
      answersEN: [
        "Deterministic scheduler / explicit await of state emission",
        "Add random sleep",
        "Run tests twice",
        "Disable assertions for loading state"
      ],
      answersBG: [
        "Детерминиран scheduler / явен await на state emission",
        "Случаен sleep",
        "Пускане на теста два пъти",
        "Спиране на assertions за loading"
      ],
      correctEN: "Deterministic scheduler / explicit await of state emission",
      correctBG: "Детерминиран scheduler / явен await на state emission",
      explanationEN: "Tests must synchronize with state emissions explicitly to avoid timing races.",
      explanationBG: "Тестът трябва явно да се синхронизира със state emission-ите, за да няма timing race."
    },
    advanced: {
      questionEN: "A large team wants confidence that ViewModel contracts stay stable across refactors. Which testing layer is best?",
      questionBG: "Голям екип иска гаранция, че ViewModel договорите остават стабилни при рефактори. Кой тестов слой е най-подходящ?",
      answersEN: [
        "Contract tests for public ViewModel I/O",
        "Only snapshot tests",
        "Manual QA scripts only",
        "Compile without tests"
      ],
      answersBG: [
        "Contract тестове за публичния ViewModel I/O",
        "Само snapshot тестове",
        "Само ръчни QA скриптове",
        "Компилация без тестове"
      ],
      correctEN: "Contract tests for public ViewModel I/O",
      correctBG: "Contract тестове за публичния ViewModel I/O",
      explanationEN: "Contract tests lock observable behavior while allowing internal refactors safely.",
      explanationBG: "Contract тестовете заключват наблюдаемото поведение и позволяват безопасни вътрешни рефактори."
    }
  },
  {
    beginner: {
      questionEN: "A profile form ViewModel directly imports Core Data entities. What separation is missing?",
      questionBG: "ViewModel на profile форма импортва директно Core Data ентитети. Кое разделение липсва?",
      answersEN: [
        "Domain model mapping layer",
        "More @Published properties",
        "Another storyboard scene",
        "A larger ViewController"
      ],
      answersBG: [
        "Domain model mapping слой",
        "Още @Published свойства",
        "Още една storyboard сцена",
        "По-голям ViewController"
      ],
      correctEN: "Domain model mapping layer",
      correctBG: "Domain model mapping слой",
      explanationEN: "Mapping isolates persistence details so ViewModel depends on domain/presentation models only.",
      explanationBG: "Mapping слоят изолира persistence детайлите, за да зависи ViewModel само от domain/presentation модели."
    },
    intermediate: {
      questionEN: "API and local DB use different field names and nullability. Where should normalization happen?",
      questionBG: "API и локалната база имат различни имена и nullability на полетата. Къде трябва да стане нормализацията?",
      answersEN: [
        "Repository mapper layer",
        "UIView rendering code",
        "Coordinator routing table",
        "Launch screen setup"
      ],
      answersBG: [
        "Mapper слой в repository",
        "UIView рендериране",
        "Coordinator routing таблица",
        "Настройка на launch screen"
      ],
      correctEN: "Repository mapper layer",
      correctBG: "Mapper слой в repository",
      explanationEN: "Normalization in the repository boundary keeps ViewModels clean and source-agnostic.",
      explanationBG: "Нормализацията на границата на repository държи ViewModel чист и независим от източника."
    },
    advanced: {
      questionEN: "Mapping bugs silently drop critical fields across modules. What engineering practice prevents this?",
      questionBG: "Mapping бъгове тихо изпускат критични полета между модули. Коя инженерна практика го предотвратява?",
      answersEN: [
        "Schema-driven mappers with strict decoding tests",
        "Manual mapping by memory",
        "Ignore unknown fields everywhere",
        "Map only fields visible on current screen"
      ],
      answersBG: [
        "Schema-driven mapper-и със строги decoding тестове",
        "Ръчно mapping по памет",
        "Игнориране на unknown полета навсякъде",
        "Mapping само на видимите полета"
      ],
      correctEN: "Schema-driven mappers with strict decoding tests",
      correctBG: "Schema-driven mapper-и със строги decoding тестове",
      explanationEN: "Schema-driven mapping plus strict tests catches drift immediately when contracts change.",
      explanationBG: "Schema-driven mapping плюс строги тестове хващат drift веднага при промяна на договорите."
    }
  },
  {
    beginner: {
      questionEN: "A SwiftUI screen owns its ViewModel but it keeps resetting on redraw. Which wrapper should be used?",
      questionBG: "SwiftUI екран притежава ViewModel, но той се ресетва при redraw. Кой wrapper трябва да се използва?",
      answersEN: [
        "@StateObject",
        "@ObservedObject",
        "@EnvironmentObject only",
        "@AppStorage"
      ],
      answersBG: [
        "@StateObject",
        "@ObservedObject",
        "@EnvironmentObject only",
        "@AppStorage"
      ],
      correctEN: "@StateObject",
      correctBG: "@StateObject",
      explanationEN: "@StateObject preserves ownership across redraws for view-owned observable objects.",
      explanationBG: "@StateObject запазва собствеността през redraw, когато изгледът притежава обекта."
    },
    intermediate: {
      questionEN: "A child SwiftUI view receives ViewModel from parent and should not recreate it. Which wrapper is correct?",
      questionBG: "Child SwiftUI view получава ViewModel от родител и не трябва да го създава наново. Кой wrapper е правилен?",
      answersEN: [
        "@ObservedObject",
        "@StateObject",
        "@SceneStorage",
        "@Namespace"
      ],
      answersBG: [
        "@ObservedObject",
        "@StateObject",
        "@SceneStorage",
        "@Namespace"
      ],
      correctEN: "@ObservedObject",
      correctBG: "@ObservedObject",
      explanationEN: "Use @ObservedObject when ownership is external and view only observes updates.",
      explanationBG: "@ObservedObject се ползва, когато собствеността е външна и view само наблюдава промени."
    },
    advanced: {
      questionEN: "Global session ViewModel leaks into unrelated previews and tests. What injection strategy is cleaner?",
      questionBG: "Глобален session ViewModel се разлива в несвързани preview-та и тестове. Коя стратегия за инжекция е по-чиста?",
      answersEN: [
        "Scoped environment injection per feature root",
        "Single global static environment object",
        "Create session VM in every subview",
        "Read session from UserDefaults each render"
      ],
      answersBG: [
        "Scoped environment инжекция на feature root",
        "Един глобален static environment object",
        "Създаване на session VM във всяко subview",
        "Четене на session от UserDefaults при всеки render"
      ],
      correctEN: "Scoped environment injection per feature root",
      correctBG: "Scoped environment инжекция на feature root",
      explanationEN: "Scoped injection limits coupling and keeps previews/tests deterministic.",
      explanationBG: "Scoped инжекцията ограничава свързаността и прави preview/test средата детерминирана."
    }
  },
  {
    beginner: {
      questionEN: "A detail screen needs to trigger a save action and then close. Where should save logic live?",
      questionBG: "Detail екран трябва да запише промяна и после да се затвори. Къде трябва да е логиката за save?",
      answersEN: [
        "ViewModel triggers save, coordinator handles close",
        "View directly writes DB and pops",
        "Coordinator validates fields",
        "Repository closes screen"
      ],
      answersBG: [
        "ViewModel прави save, coordinator затваря",
        "View записва директно в DB и pop-ва",
        "Coordinator валидира полета",
        "Repository затваря екрана"
      ],
      correctEN: "ViewModel triggers save, coordinator handles close",
      correctBG: "ViewModel прави save, coordinator затваря",
      explanationEN: "ViewModel owns action logic; coordinator owns navigation side effects.",
      explanationBG: "ViewModel държи действието, а coordinator управлява навигационния ефект."
    },
    intermediate: {
      questionEN: "Navigation happens before save completes, causing data loss. What sequencing is correct?",
      questionBG: "Навигацията се случва преди save да приключи и има загуба на данни. Коя последователност е правилна?",
      answersEN: [
        "Await save result then emit close route",
        "Emit close route first then fire save",
        "Close and rely on autosave guess",
        "Save in deinit only"
      ],
      answersBG: [
        "Изчакай save резултата и после close route",
        "Първо close route, после save",
        "Затваряне и надежда за autosave",
        "Save само в deinit"
      ],
      correctEN: "Await save result then emit close route",
      correctBG: "Изчакай save резултата и после close route",
      explanationEN: "Correct sequencing prevents premature dismissal and preserves transactional user intent.",
      explanationBG: "Правилната последователност спира преждевременно затваряне и пази транзакционното намерение на потребителя."
    },
    advanced: {
      questionEN: "Complex multi-step flow needs undo across screens. What architecture supports this in MVVM + coordinators?",
      questionBG: "Сложен многостъпков поток иска undo между екрани. Коя архитектура го поддържа в MVVM + coordinator?",
      answersEN: [
        "Flow-level state coordinator with reversible commands",
        "Local state per screen only",
        "Static global undo stack with strings",
        "Disable back navigation"
      ],
      answersBG: [
        "Flow-level state coordinator с обратими команди",
        "Само локално състояние на екран",
        "Global undo stack със string-и",
        "Изключване на back навигацията"
      ],
      correctEN: "Flow-level state coordinator with reversible commands",
      correctBG: "Flow-level state coordinator с обратими команди",
      explanationEN: "Flow-level reversible commands capture intent history across screens consistently.",
      explanationBG: "Flow-level обратимите команди пазят история на намеренията последователно между екраните."
    }
  },
  {
    beginner: {
      questionEN: "A search ViewModel sends request per keystroke and hammers API. What is the first fix?",
      questionBG: "Search ViewModel праща заявка при всяко натискане и товари API-то. Кой е първият fix?",
      answersEN: [
        "Debounce query input",
        "Increase font size",
        "Use more threads",
        "Disable search field"
      ],
      answersBG: [
        "Debounce на query входа",
        "Увеличаване на шрифта",
        "Повече thread-ове",
        "Изключване на search полето"
      ],
      correctEN: "Debounce query input",
      correctBG: "Debounce на query входа",
      explanationEN: "Debouncing coalesces noisy input and reduces unnecessary backend calls.",
      explanationBG: "Debounce обединява шумния вход и намалява излишните заявки към backend."
    },
    intermediate: {
      questionEN: "Out-of-order search responses show old results after new query. What should ViewModel enforce?",
      questionBG: "Out-of-order отговори от търсене показват стари резултати след нова заявка. Какво трябва да наложи ViewModel?",
      answersEN: [
        "Cancel previous task / validate query token",
        "Always keep first response",
        "Sort by response size",
        "Ignore user typing speed"
      ],
      answersBG: [
        "Cancel на предишната задача / проверка на query token",
        "Винаги пази първия отговор",
        "Сортиране по размер на отговор",
        "Игнорирай скоростта на писане"
      ],
      correctEN: "Cancel previous task / validate query token",
      correctBG: "Cancel на предишната задача / проверка на query token",
      explanationEN: "Cancellation/token checks guarantee only latest intent updates state.",
      explanationBG: "Cancel/token проверките гарантират, че само последното намерение обновява състоянието."
    },
    advanced: {
      questionEN: "Search supports filters, sort, and server facets with caching. What ViewModel state design is robust?",
      questionBG: "Търсенето поддържа филтри, сортиране и server facets с кеш. Кой дизайн на ViewModel state е устойчив?",
      answersEN: [
        "Canonical query object as cache/state key",
        "Separate booleans per filter without keying",
        "One mutable URL string",
        "Reset all state on each filter change"
      ],
      answersBG: [
        "Каноничен query обект като cache/state ключ",
        "Отделни boolean-и без keying",
        "Един mutable URL string",
        "Пълен reset на state при всяка промяна"
      ],
      correctEN: "Canonical query object as cache/state key",
      correctBG: "Каноничен query обект като cache/state ключ",
      explanationEN: "Canonical query keys unify caching, dedupe, and deterministic rendering for complex search.",
      explanationBG: "Каноничният query ключ обединява кеширане, dedupe и детерминирано рендериране при сложни търсения."
    }
  },
  {
    beginner: {
      questionEN: "A ViewModel publishes too many tiny updates causing UI jitter. What improvement is practical?",
      questionBG: "ViewModel публикува твърде много дребни update-и и UI трепти. Кое подобрение е практично?",
      answersEN: [
        "Publish coalesced state updates",
        "Publish every field separately on change",
        "Update via NotificationCenter only",
        "Disable animations globally"
      ],
      answersBG: [
        "Публикувай обединени state обновявания",
        "Публикувай всяко поле отделно",
        "Update само чрез NotificationCenter",
        "Глобално изключване на анимации"
      ],
      correctEN: "Publish coalesced state updates",
      correctBG: "Публикувай обединени state обновявания",
      explanationEN: "Coalesced updates reduce redraw churn and keep UI transitions smoother.",
      explanationBG: "Обединените обновявания намаляват redraw шума и правят UI преходите по-плавни."
    },
    intermediate: {
      questionEN: "A heavy list re-renders on unrelated state change. Which state structuring helps?",
      questionBG: "Тежък списък се ререндерира при несвързана промяна на state. Кое структуриране помага?",
      answersEN: [
        "Split screen state into independent sub-states",
        "One giant mutable dictionary",
        "Store all state in view",
        "Use random UUID each render"
      ],
      answersBG: [
        "Раздели screen state на независими sub-state части",
        "Един огромен mutable dictionary",
        "Всичко състояние във view",
        "Случаен UUID на всеки render"
      ],
      correctEN: "Split screen state into independent sub-states",
      correctBG: "Раздели screen state на независими sub-state части",
      explanationEN: "Granular state partitioning limits invalidation scope and avoids unnecessary list redraws.",
      explanationBG: "Гранулираното разделяне на state-а ограничава invalidation обхвата и спира излишния redraw на списъка."
    },
    advanced: {
      questionEN: "Performance budget requires measuring ViewModel-to-render latency. What metric instrumentation should you add?",
      questionBG: "Има performance бюджет и трябва да се мери латентността от ViewModel до render. Каква метрика добавяш?",
      answersEN: [
        "Timestamped intent-to-render tracing",
        "Only FPS average once per day",
        "Manual stopwatch testing",
        "No metrics in production"
      ],
      answersBG: [
        "Tracing с timestamp от intent до render",
        "Само среден FPS веднъж дневно",
        "Ръчно мерене със stopwatch",
        "Без метрики в production"
      ],
      correctEN: "Timestamped intent-to-render tracing",
      correctBG: "Tracing с timestamp от intent до render",
      explanationEN: "Intent-to-render traces pinpoint where latency accumulates across pipeline stages.",
      explanationBG: "Intent-to-render trace показва точно къде се натрупва латентността по етапите на потока."
    }
  },
  {
    beginner: {
      questionEN: "A ViewModel stores DateFormatter per row creation and performance drops. What is better?",
      questionBG: "ViewModel създава DateFormatter за всеки ред и производителността пада. Кое е по-добре?",
      answersEN: [
        "Reuse formatter through injected formatting service",
        "Create formatter in every cell",
        "Format dates in SQL query text",
        "Disable date display"
      ],
      answersBG: [
        "Преизползване чрез injected formatting service",
        "Formatter във всяка клетка",
        "Форматиране в SQL текста",
        "Скриване на датите"
      ],
      correctEN: "Reuse formatter through injected formatting service",
      correctBG: "Преизползване чрез injected formatting service",
      explanationEN: "Formatter reuse avoids repeated expensive allocations and keeps ViewModel lean.",
      explanationBG: "Преизползването на formatter-и спестява скъпи алокации и държи ViewModel по-лек."
    },
    intermediate: {
      questionEN: "Formatting rules differ between modules causing inconsistent currency symbols. What architecture fix applies?",
      questionBG: "Форматирането е различно между модулите и символът на валутата е непоследователен. Кой архитектурен fix е приложим?",
      answersEN: [
        "Centralized formatting policy service",
        "Each module picks locale manually",
        "Hardcode symbol in view labels",
        "Store preformatted string in API"
      ],
      answersBG: [
        "Централизирана formatting policy услуга",
        "Всеки модул избира locale ръчно",
        "Твърд символ в labels",
        "Предварително форматиран string в API"
      ],
      correctEN: "Centralized formatting policy service",
      correctBG: "Централизирана formatting policy услуга",
      explanationEN: "Central policy ensures consistency and simplifies global changes to formatting behavior.",
      explanationBG: "Централната политика гарантира консистентност и улеснява глобални промени във форматирането."
    },
    advanced: {
      questionEN: "App needs locale- and customer-tier-specific formatting with A/B rollouts. What system scales safely?",
      questionBG: "Приложението иска форматиране според locale и customer tier с A/B rollout. Коя система скалира безопасно?",
      answersEN: [
        "Rule-based formatter registry with versioned configs",
        "if-else ladder in every ViewModel",
        "One static global formatter",
        "Manual update per release note"
      ],
      answersBG: [
        "Rule-based formatter registry с versioned конфигурации",
        "if-else стълба във всеки ViewModel",
        "Един static глобален formatter",
        "Ръчни промени по release note"
      ],
      correctEN: "Rule-based formatter registry with versioned configs",
      correctBG: "Rule-based formatter registry с versioned конфигурации",
      explanationEN: "Versioned rule registries support controlled experiments without fragmenting formatting logic.",
      explanationBG: "Versioned rule registry позволява контролирани експерименти без разпадане на логиката за форматиране."
    }
  },
  {
    beginner: {
      questionEN: "A list ViewModel must expose pull-to-refresh action. How should View communicate this?",
      questionBG: "List ViewModel трябва да поддържа pull-to-refresh действие. Как View трябва да го подава?",
      answersEN: [
        "Intent method like refresh()",
        "Direct repository call from view",
        "Notification with random name",
        "Mutate loading flag directly"
      ],
      answersBG: [
        "Intent метод като refresh()",
        "Директно repository извикване от view",
        "Notification със случаен name",
        "Директна промяна на loading флага"
      ],
      correctEN: "Intent method like refresh()",
      correctBG: "Intent метод като refresh()",
      explanationEN: "Explicit intents keep interaction contracts clear and testable.",
      explanationBG: "Явните intent методи правят договора за взаимодействие ясен и тестируем."
    },
    intermediate: {
      questionEN: "Refresh and pagination overlap and duplicate items appear. What control should ViewModel enforce?",
      questionBG: "Refresh и pagination се припокриват и се появяват дубликати. Какъв контрол трябва да наложи ViewModel?",
      answersEN: [
        "Mutual exclusion + merge policy by stable ID",
        "Allow both freely",
        "Clear list on every page",
        "Disable refresh permanently"
      ],
      answersBG: [
        "Взаимно изключване + merge политика по стабилен ID",
        "Свободно паралелно изпълнение",
        "Изчистване на списъка при всяка страница",
        "Постоянно изключен refresh"
      ],
      correctEN: "Mutual exclusion + merge policy by stable ID",
      correctBG: "Взаимно изключване + merge политика по стабилен ID",
      explanationEN: "Coordinated fetch states and stable-ID merges prevent race-driven duplicates.",
      explanationBG: "Координираните fetch състояния и merge по стабилен ID предотвратяват дубликати от race condition."
    },
    advanced: {
      questionEN: "You need offline refresh previews while preserving eventual consistency after reconnect. What model is robust?",
      questionBG: "Трябва офлайн refresh preview, но и eventual consistency след връщане на мрежата. Кой модел е устойчив?",
      answersEN: [
        "Optimistic local projection + reconciliation sync",
        "Block refresh when offline forever",
        "Use only server truth and blank UI",
        "Duplicate storage per tab"
      ],
      answersBG: [
        "Optimistic локална проекция + reconciliation sync",
        "Пълна забрана на refresh офлайн",
        "Само server truth и празен UI",
        "Дублирано хранилище за всеки таб"
      ],
      correctEN: "Optimistic local projection + reconciliation sync",
      correctBG: "Optimistic локална проекция + reconciliation sync",
      explanationEN: "Optimistic projection preserves responsiveness, while reconciliation restores canonical state safely.",
      explanationBG: "Optimistic проекция пази бърз отговор, а reconciliation връща канонично състояние безопасно."
    }
  },
  {
    beginner: {
      questionEN: "A checkout ViewModel is 1200 lines and hard to reason about. What first refactor helps?",
      questionBG: "Checkout ViewModel е 1200 реда и е труден за разбиране. Кой първи рефактор помага?",
      answersEN: [
        "Split into focused use-case services",
        "Add more comments only",
        "Move code to ViewController",
        "Inline repository code"
      ],
      answersBG: [
        "Разделяне към фокусирани use-case услуги",
        "Само повече коментари",
        "Преместване във ViewController",
        "Inline на repository кода"
      ],
      correctEN: "Split into focused use-case services",
      correctBG: "Разделяне към фокусирани use-case услуги",
      explanationEN: "Use-case extraction shrinks cognitive load and clarifies responsibilities.",
      explanationBG: "Изнасянето към use-case услуги намалява когнитивната тежест и изяснява отговорностите."
    },
    intermediate: {
      questionEN: "Refactor broke behavior because hidden side effects were undocumented. What process prevents this?",
      questionBG: "Рефактор счупи поведение, защото скритите side effects не са документирани. Кой процес го предотвратява?",
      answersEN: [
        "Characterization tests before refactor",
        "Refactor directly on Friday release",
        "Manual memory of behavior",
        "Delete old tests"
      ],
      answersBG: [
        "Characterization тестове преди рефактор",
        "Рефактор директно в петъчния release",
        "Разчитане на паметта на екипа",
        "Изтриване на старите тестове"
      ],
      correctEN: "Characterization tests before refactor",
      correctBG: "Characterization тестове преди рефактор",
      explanationEN: "Characterization tests lock current behavior, allowing safe structural refactors.",
      explanationBG: "Characterization тестовете заключват текущото поведение и позволяват безопасен структурен рефактор."
    },
    advanced: {
      questionEN: "Team wants continuous architecture health for MVVM layers. Which governance mechanism is strongest?",
      questionBG: "Екипът иска непрекъснат архитектурен контрол върху MVVM слоевете. Кой governance механизъм е най-силен?",
      answersEN: [
        "Architecture fitness functions in CI",
        "Occasional tribal reviews",
        "No rules, rely on seniors",
        "Only style linting"
      ],
      answersBG: [
        "Architecture fitness функции в CI",
        "Случайни неформални review-та",
        "Без правила, само senior опит",
        "Само style lint"
      ],
      correctEN: "Architecture fitness functions in CI",
      correctBG: "Architecture fitness функции в CI",
      explanationEN: "Fitness functions continuously enforce boundary and dependency rules at scale.",
      explanationBG: "Fitness функциите налагат непрекъснато правилата за граници и зависимости при мащаб."
    }
  },
  {
    beginner: {
      questionEN: "A ViewModel writes navigation title strings in three places. How to centralize?",
      questionBG: "ViewModel задава navigation title на три места. Как да се централизира?",
      answersEN: [
        "Expose one derived title in state",
        "Set title from each button action",
        "Keep title in storyboard only",
        "Use random title per reload"
      ],
      answersBG: [
        "Едно derived title поле в state",
        "Заглавие от всеки button action",
        "Заглавие само в storyboard",
        "Случайно заглавие при reload"
      ],
      correctEN: "Expose one derived title in state",
      correctBG: "Едно derived title поле в state",
      explanationEN: "One derived field prevents divergence and keeps title logic testable.",
      explanationBG: "Едно derived поле спира разминаванията и пази логиката за заглавие тестируема."
    },
    intermediate: {
      questionEN: "Localization changes title per locale and account type. Where should this transformation happen?",
      questionBG: "Локализацията променя заглавието според locale и тип акаунт. Къде трябва да е тази трансформация?",
      answersEN: [
        "Presentation mapper in ViewModel layer",
        "UIView subclass draw()",
        "Repository network adapter",
        "SceneDelegate only"
      ],
      answersBG: [
        "Presentation mapper във ViewModel слоя",
        "UIView subclass draw()",
        "Repository network adapter",
        "Само в SceneDelegate"
      ],
      correctEN: "Presentation mapper in ViewModel layer",
      correctBG: "Presentation mapper във ViewModel слоя",
      explanationEN: "Locale-aware presentation mapping belongs close to UI state composition, not data transport layers.",
      explanationBG: "Locale-aware presentation mapping е близо до композицията на UI състояние, не до data transport слоевете."
    },
    advanced: {
      questionEN: "Marketing requests dynamic title experiments by cohort with safe fallback. What design is best?",
      questionBG: "Маркетингът иска динамични title експерименти по cohort със safe fallback. Кой дизайн е най-добър?",
      answersEN: [
        "Title policy provider with default fallback chain",
        "If-else in every view",
        "Remote string injection without validation",
        "Manual edits per language file"
      ],
      answersBG: [
        "Title policy provider с default fallback верига",
        "If-else във всеки view",
        "Remote низове без валидация",
        "Ръчни промени във всеки езиков файл"
      ],
      correctEN: "Title policy provider with default fallback chain",
      correctBG: "Title policy provider с default fallback верига",
      explanationEN: "Policy providers support experiments while guaranteeing deterministic fallback behavior.",
      explanationBG: "Policy provider-ите позволяват експерименти и гарантират детерминиран fallback."
    }
  },
  {
    beginner: {
      questionEN: "A table screen loads data in viewDidAppear repeatedly on every tab switch. In MVVM, what is cleaner?",
      questionBG: "Табличен екран зарежда данни във viewDidAppear при всяка смяна на таб. В MVVM кое е по-чисто?",
      answersEN: [
        "Explicit ViewModel lifecycle intent (onAppearOnce/onRefresh)",
        "Always fetch in cellForRow",
        "Fetch in AppDelegate every second",
        "Disable tab switching"
      ],
      answersBG: [
        "Явен ViewModel lifecycle intent (onAppearOnce/onRefresh)",
        "Винаги fetch в cellForRow",
        "Fetch в AppDelegate всяка секунда",
        "Изключване на tab switching"
      ],
      correctEN: "Explicit ViewModel lifecycle intent (onAppearOnce/onRefresh)",
      correctBG: "Явен ViewModel lifecycle intent (onAppearOnce/onRefresh)",
      explanationEN: "Explicit intents differentiate initial load from refresh and avoid accidental refetch loops.",
      explanationBG: "Явните intent-и разделят първоначално зареждане от refresh и спират неволни цикли на презареждане."
    },
    intermediate: {
      questionEN: "Returning to screen should refresh only if cache is older than 5 minutes. Who decides this policy?",
      questionBG: "При връщане към екрана трябва refresh само ако кешът е по-стар от 5 минути. Кой решава тази политика?",
      answersEN: [
        "Repository/cache policy, triggered by ViewModel intent",
        "UIViewController hardcoded timer",
        "Storyboard segue conditions",
        "Random chance in ViewModel"
      ],
      answersBG: [
        "Repository/cache политика, стартирана от ViewModel intent",
        "Твърд timer във UIViewController",
        "Storyboard segue условия",
        "Случаен избор във ViewModel"
      ],
      correctEN: "Repository/cache policy, triggered by ViewModel intent",
      correctBG: "Repository/cache политика, стартирана от ViewModel intent",
      explanationEN: "ViewModel asks for data; repository decides freshness using cache policy.",
      explanationBG: "ViewModel заявява нужда от данни, а repository решава актуалността чрез cache политика."
    },
    advanced: {
      questionEN: "A product wants adaptive refresh policy based on network cost and battery level. What architecture supports this?",
      questionBG: "Продуктът иска адаптивна refresh политика според мрежова цена и батерия. Коя архитектура поддържа това?",
      answersEN: [
        "Policy engine injected into repository and ViewModel",
        "Hardcoded polling interval globally",
        "UserDefaults boolean only",
        "Manual QA toggles"
      ],
      answersBG: [
        "Policy engine, инжектиран в repository и ViewModel",
        "Твърд глобален polling интервал",
        "Само boolean в UserDefaults",
        "Ръчни QA превключватели"
      ],
      correctEN: "Policy engine injected into repository and ViewModel",
      correctBG: "Policy engine, инжектиран в repository и ViewModel",
      explanationEN: "Policy engines encapsulate dynamic constraints while keeping ViewModel code maintainable.",
      explanationBG: "Policy engine капсулира динамичните ограничения и пази ViewModel кода поддържаем."
    }
  },
  {
    beginner: {
      questionEN: "A dialog action should be disabled when form is invalid. Where should `isSubmitEnabled` be computed?",
      questionBG: "Диалогов бутон трябва да е неактивен при невалидна форма. Къде се изчислява `isSubmitEnabled`?",
      answersEN: [
        "ViewModel derived state",
        "UIButton subclass",
        "Repository layer",
        "Coordinator only"
      ],
      answersBG: [
        "Derived state във ViewModel",
        "UIButton subclass",
        "Repository слой",
        "Само coordinator"
      ],
      correctEN: "ViewModel derived state",
      correctBG: "Derived state във ViewModel",
      explanationEN: "Derived UI flags belong in ViewModel because they depend on form state and rules.",
      explanationBG: "Derived UI флаговете са работа на ViewModel, защото зависят от form state и правила."
    },
    intermediate: {
      questionEN: "Button enablement lags one keystroke behind. What reactive fix is likely needed?",
      questionBG: "Активирането на бутона изостава с едно натискане на клавиш. Коя реактивна корекция е вероятна?",
      answersEN: [
        "Ensure state pipeline updates on latest input before render",
        "Add another text field delegate",
        "Use delay on UI updates",
        "Compute enablement in coordinator"
      ],
      answersBG: [
        "Гарантирай, че state pipeline обработва последния вход преди render",
        "Още един text field delegate",
        "Добави забавяне на UI update",
        "Изчислявай enablement в coordinator"
      ],
      correctEN: "Ensure state pipeline updates on latest input before render",
      correctBG: "Гарантирай, че state pipeline обработва последния вход преди render",
      explanationEN: "Lag usually means ordering issues in state propagation; fix the pipeline order, not UI hacks.",
      explanationBG: "Изоставането обикновено е проблем в реда на state propagation; решението е в pipeline-а, не в UI трикове."
    },
    advanced: {
      questionEN: "Complex form has 40 fields and dynamic business rules. Which MVVM approach keeps validation maintainable?",
      questionBG: "Сложна форма има 40 полета и динамични бизнес правила. Кой MVVM подход държи валидацията поддържаема?",
      answersEN: [
        "Composable validation rule graph with typed results",
        "One giant if-else in ViewModel",
        "Validation in each cell",
        "Backend-only validation and no local checks"
      ],
      answersBG: [
        "Composable validation rule graph с типизирани резултати",
        "Един огромен if-else във ViewModel",
        "Валидация във всяка клетка",
        "Само backend валидация без локални проверки"
      ],
      correctEN: "Composable validation rule graph with typed results",
      correctBG: "Composable validation rule graph с типизирани резултати",
      explanationEN: "Composable rule graphs scale with complexity and provide explainable per-field outcomes.",
      explanationBG: "Composable rule graph-ът скалира при сложност и дава обясним резултат за всяко поле."
    }
  },
  {
    beginner: {
      questionEN: "A ViewModel updates a spinner flag in several methods and misses one path. What simplification helps?",
      questionBG: "ViewModel обновява spinner флаг в много методи и пропуска един път. Кое опростяване помага?",
      answersEN: [
        "Use centralized loading state transition helpers",
        "Set spinner directly in views",
        "Hide spinner permanently",
        "Add another boolean"
      ],
      answersBG: [
        "Централизирани helper-и за loading state преходи",
        "Директно задаване от view",
        "Постоянно скриване на spinner",
        "Още един boolean"
      ],
      correctEN: "Use centralized loading state transition helpers",
      correctBG: "Централизирани helper-и за loading state преходи",
      explanationEN: "Central transitions reduce duplicated mutation logic and missing branches.",
      explanationBG: "Централните преходи намаляват дублираната логика за мутации и пропуснатите клонове."
    },
    intermediate: {
      questionEN: "Loading indicator never stops when request fails with timeout. Which state rule is missing?",
      questionBG: "Loading индикаторът не спира при timeout грешка. Кое state правило липсва?",
      answersEN: [
        "Finalize loading in success and failure paths",
        "Stop loading only on success",
        "Ignore timeout errors",
        "Reset app on timeout"
      ],
      answersBG: [
        "Завършване на loading и при success, и при failure",
        "Спиране само при success",
        "Игнориране на timeout грешки",
        "Рестарт на app при timeout"
      ],
      correctEN: "Finalize loading in success and failure paths",
      correctBG: "Завършване на loading и при success, и при failure",
      explanationEN: "All terminal outcomes must clear loading to avoid stuck UI states.",
      explanationBG: "Всички крайни изходи трябва да изчистват loading, иначе UI остава блокиран."
    },
    advanced: {
      questionEN: "Nested operations need independent loading indicators and global busy state. What design supports both?",
      questionBG: "Вложени операции искат отделни loading индикатори и общ busy state. Кой дизайн поддържа и двете?",
      answersEN: [
        "Hierarchical loading state model with scopes",
        "Single global isLoading boolean",
        "Per-button random timers",
        "No loading indicators"
      ],
      answersBG: [
        "Йерархичен loading модел със scope-ове",
        "Един глобален isLoading boolean",
        "Случайни timer-и за бутоните",
        "Без loading индикатори"
      ],
      correctEN: "Hierarchical loading state model with scopes",
      correctBG: "Йерархичен loading модел със scope-ове",
      explanationEN: "Scoped loading state represents concurrent operations without collapsing everything into one flag.",
      explanationBG: "Scoped loading state описва конкурентни операции, без всичко да се свива в един флаг."
    }
  }
];
