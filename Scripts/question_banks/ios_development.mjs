export default [
  {
    beginner: {
      questionEN: "On first app launch, analytics must be initialized before any screen appears. Where should this start?",
      questionBG: "При първо стартиране трябва да инициализираш analytics преди да се покаже екран. Откъде започваш?",
      answersEN: [
        "application(_:didFinishLaunchingWithOptions:)",
        "viewDidAppear",
        "sceneDidEnterBackground",
        "prepareForSegue"
      ],
      answersBG: [
        "application(_:didFinishLaunchingWithOptions:)",
        "viewDidAppear",
        "sceneDidEnterBackground",
        "prepareForSegue"
      ],
      correctEN: "application(_:didFinishLaunchingWithOptions:)",
      correctBG: "application(_:didFinishLaunchingWithOptions:)",
      explanationEN: "This delegate callback runs once during process launch, before UI interaction. It is the right place for global setup like analytics SDK bootstrap.",
      explanationBG: "Този callback се извиква при стартиране на процеса, преди потребителят да работи с UI. Затова е правилното място за глобална инициализация като analytics SDK."
    },
    intermediate: {
      questionEN: "A crash happens only when users open a second iPad window. Which lifecycle API should you inspect first?",
      questionBG: "Сривът се появява само когато на iPad се отвори втори прозорец. Кой lifecycle API проверяваш първо?",
      answersEN: [
        "scene(_:willConnectTo:options:)",
        "applicationWillTerminate",
        "viewWillLayoutSubviews",
        "deinit in AppDelegate"
      ],
      answersBG: [
        "scene(_:willConnectTo:options:)",
        "applicationWillTerminate",
        "viewWillLayoutSubviews",
        "deinit in AppDelegate"
      ],
      correctEN: "scene(_:willConnectTo:options:)",
      correctBG: "scene(_:willConnectTo:options:)",
      explanationEN: "Multi-window behavior is scene-driven. New windows create new scenes, so this method is where per-window setup errors usually surface.",
      explanationBG: "Поведение с няколко прозореца се управлява от scene системата. Нов прозорец създава нова scene, затова тук най-често се виждат проблемите в инициализацията."
    },
    advanced: {
      questionEN: "A deep link opens the app cold and must route to the correct tab after state restoration. What architecture is safest?",
      questionBG: "Deep link стартира приложението от нулата и трябва да отвори правилния таб след възстановяване на състоянието. Коя архитектура е най-сигурна?",
      answersEN: [
        "Central router handling launch + scene events",
        "Hardcode routing in every ViewController",
        "Use only storyboard segues",
        "Delay all links until next launch"
      ],
      answersBG: [
        "Централен router за launch + scene събития",
        "Твърдо кодиране във всеки ViewController",
        "Само storyboard segues",
        "Отлагане на всички линкове до следващ старт"
      ],
      correctEN: "Central router handling launch + scene events",
      correctBG: "Централен router за launch + scene събития",
      explanationEN: "Cold start, warm start, and multi-scene entry points differ. A central router unifies these flows and avoids duplicated fragile navigation logic.",
      explanationBG: "Cold старт, warm старт и multi-scene входове са различни. Централен router ги обединява и избягва дублирана, чуплива навигационна логика."
    }
  },
  {
    beginner: {
      questionEN: "The profile screen freezes while loading an avatar from the network. What should happen to the request?",
      questionBG: "Екранът с профила замръзва при зареждане на аватар от мрежата. Как трябва да се изпълнява заявката?",
      answersEN: [
        "Use URLSession async request",
        "Download in viewDidLoad synchronously",
        "Use UserDefaults for image bytes",
        "Render placeholder forever"
      ],
      answersBG: [
        "URLSession асинхронна заявка",
        "Синхронно теглене във viewDidLoad",
        "UserDefaults за байтове на изображение",
        "Постоянен placeholder"
      ],
      correctEN: "Use URLSession async request",
      correctBG: "URLSession асинхронна заявка",
      explanationEN: "Network calls must be asynchronous so the main thread stays responsive. URLSession provides non-blocking APIs designed for this exact case.",
      explanationBG: "Мрежовите заявки трябва да са асинхронни, за да не блокират основния thread. URLSession дава точно такъв неблокиращ механизъм."
    },
    intermediate: {
      questionEN: "A request should retry only on timeout and 5xx responses, but never on 401. What strategy fits?",
      questionBG: "Заявката трябва да се повтори само при timeout и 5xx, но никога при 401. Коя стратегия е правилна?",
      answersEN: [
        "Retry policy based on status/error classification",
        "Always retry 3 times",
        "Never inspect response codes",
        "Retry only on Wi-Fi"
      ],
      answersBG: [
        "Retry политика по статус/грешка",
        "Винаги 3 повторения",
        "Без проверка на response код",
        "Повторение само на Wi-Fi"
      ],
      correctEN: "Retry policy based on status/error classification",
      correctBG: "Retry политика по статус/грешка",
      explanationEN: "401 usually requires re-authentication, while timeouts/5xx are often transient. Classified retry rules prevent loops and improve reliability.",
      explanationBG: "401 обикновено изисква нова автентикация, а timeout/5xx често са временни. Класифицираната retry логика спира безкрайни цикли и е по-надеждна."
    },
    advanced: {
      questionEN: "After app relaunch, stale data appears even though the server changed. What should networking include?",
      questionBG: "След рестарт на приложението се виждат стари данни, въпреки че сървърът е обновен. Какво трябва да включва networking слоят?",
      answersEN: [
        "HTTP cache validation with ETag/If-None-Match",
        "Disable all caching permanently",
        "Fetch only once per install",
        "Store everything in plist"
      ],
      answersBG: [
        "HTTP cache валидация с ETag/If-None-Match",
        "Пълно изключване на cache",
        "Зареждане само веднъж при инсталация",
        "Запис на всичко в plist"
      ],
      correctEN: "HTTP cache validation with ETag/If-None-Match",
      correctBG: "HTTP cache валидация с ETag/If-None-Match",
      explanationEN: "Validation requests keep bandwidth low while guaranteeing freshness. ETag workflows solve stale-cache bugs better than disabling cache globally.",
      explanationBG: "Validation заявките пазят трафик нисък и гарантират актуалност. ETag подходът решава stale-cache проблеми по-добре от глобално изключване на кеша."
    }
  },
  {
    beginner: {
      questionEN: "A toggle for 'Dark Mode Onboarding Seen' must persist between launches. Where should you save it?",
      questionBG: "Стойността „видян onboarding за тъмен режим“ трябва да се пази между стартиранията. Къде я записваш?",
      answersEN: [
        "UserDefaults",
        "NSCache only",
        "In-memory static var",
        "UILabel text"
      ],
      answersBG: [
        "UserDefaults",
        "Само NSCache",
        "In-memory static променлива",
        "UILabel text"
      ],
      correctEN: "UserDefaults",
      correctBG: "UserDefaults",
      explanationEN: "Simple preferences and flags belong in UserDefaults. It is lightweight, persisted, and built for key-value app settings.",
      explanationBG: "Прости предпочитания и флагове се пазят в UserDefaults. Това е лек, персистентен и стандартен механизъм за key-value настройки."
    },
    intermediate: {
      questionEN: "Login tokens must survive relaunch and be protected if the backup is stolen. Where should they live?",
      questionBG: "Login token-ите трябва да оцелеят след рестарт и да са защитени дори при компрометиран backup. Къде им е мястото?",
      answersEN: [
        "Keychain with proper accessibility class",
        "UserDefaults",
        "Bundle resource file",
        "Launch arguments"
      ],
      answersBG: [
        "Keychain с подходящ accessibility клас",
        "UserDefaults",
        "Файл в bundle",
        "Launch аргументи"
      ],
      correctEN: "Keychain with proper accessibility class",
      correctBG: "Keychain с подходящ accessibility клас",
      explanationEN: "Credentials require secure storage, encryption, and access control. Keychain provides these guarantees, unlike UserDefaults or bundled files.",
      explanationBG: "Идентификационните данни изискват защитено съхранение, криптиране и контрол на достъпа. Keychain дава тези гаранции, за разлика от UserDefaults и bundle файлове."
    },
    advanced: {
      questionEN: "A shopping app must work offline with thousands of products and query by category quickly. Which store is appropriate?",
      questionBG: "Магазин трябва да работи офлайн с хиляди продукти и бързо търсене по категории. Кое хранилище е подходящо?",
      answersEN: [
        "Core Data with indexed entities",
        "UserDefaults dictionary",
        "Single JSON in Documents",
        "Only remote API"
      ],
      answersBG: [
        "Core Data с индексирани ентитети",
        "UserDefaults речник",
        "Един JSON файл в Documents",
        "Само remote API"
      ],
      correctEN: "Core Data with indexed entities",
      correctBG: "Core Data с индексирани ентитети",
      explanationEN: "Relational queries, indexing, and large datasets are Core Data strengths. Flat key-value storage degrades quickly at this scale.",
      explanationBG: "Релационни заявки, индекси и големи обеми данни са силата на Core Data. Плоското key-value съхранение се разпада бързо при такъв мащаб."
    }
  },
  {
    beginner: {
      questionEN: "Push notifications never appear because permission was never requested. Which API starts this flow?",
      questionBG: "Push известия не идват, защото никога не е искано разрешение. Кой API стартира този процес?",
      answersEN: [
        "UNUserNotificationCenter.requestAuthorization",
        "registerForRemoteNotifications only",
        "URLSession.dataTask",
        "sceneWillResignActive"
      ],
      answersBG: [
        "UNUserNotificationCenter.requestAuthorization",
        "Само registerForRemoteNotifications",
        "URLSession.dataTask",
        "sceneWillResignActive"
      ],
      correctEN: "UNUserNotificationCenter.requestAuthorization",
      correctBG: "UNUserNotificationCenter.requestAuthorization",
      explanationEN: "Authorization is the user consent gate. Without it, APNs registration alone cannot deliver alert notifications.",
      explanationBG: "Разрешението е входната врата за съгласие от потребителя. Без него дори APNs регистрация не е достатъчна за alert известия."
    },
    intermediate: {
      questionEN: "Marketing wants rich push with remote image attachment. What component adds media before delivery?",
      questionBG: "Маркетингът иска rich push с изображение от URL. Кой компонент добавя медията преди показване?",
      answersEN: [
        "Notification Service Extension",
        "Share Extension",
        "WidgetKit timeline",
        "Background fetch handler"
      ],
      answersBG: [
        "Notification Service Extension",
        "Share Extension",
        "WidgetKit timeline",
        "Background fetch handler"
      ],
      correctEN: "Notification Service Extension",
      correctBG: "Notification Service Extension",
      explanationEN: "The service extension intercepts incoming notifications and can download/attach media before the system displays them.",
      explanationBG: "Service extension прихваща известието и може да изтегли/добави медия преди системата да го покаже."
    },
    advanced: {
      questionEN: "Notification opens detail screen but wrong account context is shown in multi-account setup. What is the robust fix?",
      questionBG: "Натискането на известие отваря детайл, но в грешен акаунт при multi-account приложение. Кой е устойчивият fix?",
      answersEN: [
        "Route via account-aware deep-link resolver",
        "Read last opened tab only",
        "Force logout before opening",
        "Ignore notification payload"
      ],
      answersBG: [
        "Маршрутизация чрез account-aware deep-link resolver",
        "Използване само на последния отворен таб",
        "Принудителен logout преди отваряне",
        "Игнориране на payload-а"
      ],
      correctEN: "Route via account-aware deep-link resolver",
      correctBG: "Маршрутизация чрез account-aware deep-link resolver",
      explanationEN: "Notification payload must be resolved against current account state. A resolver layer prevents cross-account navigation mistakes.",
      explanationBG: "Payload-ът трябва да се разрешава спрямо активния акаунт. Resolver слой предотвратява навигация в грешен профил."
    }
  },
  {
    beginner: {
      questionEN: "An API call to http://legacy.example.com fails only on device with ATS error. What's the immediate cause?",
      questionBG: "Заявка към http://legacy.example.com се проваля само на устройство с ATS грешка. Каква е причината?",
      answersEN: [
        "ATS blocks insecure HTTP by default",
        "DNS is unavailable in iOS",
        "App Store account is expired",
        "Storyboard is missing"
      ],
      answersBG: [
        "ATS блокира незащитен HTTP по подразбиране",
        "DNS не работи в iOS",
        "App Store акаунтът е изтекъл",
        "Липсва storyboard"
      ],
      correctEN: "ATS blocks insecure HTTP by default",
      correctBG: "ATS блокира незащитен HTTP по подразбиране",
      explanationEN: "App Transport Security requires HTTPS unless explicitly configured otherwise. Plain HTTP is denied out of the box.",
      explanationBG: "App Transport Security изисква HTTPS, освен ако изрично не е конфигурирано друго. Обикновеният HTTP се отказва по подразбиране."
    },
    intermediate: {
      questionEN: "You must call one legacy host while keeping ATS strict elsewhere. Which configuration is safest?",
      questionBG: "Трябва да ползваш един legacy хост, но ATS да остане строг за останалите домейни. Коя конфигурация е най-безопасна?",
      answersEN: [
        "Domain-specific NSExceptionDomains entry",
        "NSAllowsArbitraryLoads = YES globally",
        "Disable SSL pinning everywhere",
        "Use simulator only"
      ],
      answersBG: [
        "Domain-specific запис в NSExceptionDomains",
        "Глобално NSAllowsArbitraryLoads = YES",
        "Изключване на SSL pinning навсякъде",
        "Само в симулатор"
      ],
      correctEN: "Domain-specific NSExceptionDomains entry",
      correctBG: "Domain-specific запис в NSExceptionDomains",
      explanationEN: "A scoped exception limits risk to one host. Global arbitrary loads weakens transport security for the whole app.",
      explanationBG: "Ограниченото изключение намалява риска само до един хост. Глобалното разрешаване отслабва сигурността за цялото приложение."
    },
    advanced: {
      questionEN: "Security audit flags broad ATS exceptions in production. What long-term action is correct?",
      questionBG: "Одит по сигурността открива широки ATS изключения в production. Какво е правилното дългосрочно действие?",
      answersEN: [
        "Migrate backend to modern TLS and remove exceptions",
        "Hide exceptions in another plist",
        "Keep exceptions and add comments",
        "Downgrade to HTTP/1 only"
      ],
      answersBG: [
        "Миграция на backend към модерен TLS и махане на изключенията",
        "Скриване на изключенията в друг plist",
        "Оставяне на изключенията с коментари",
        "Понижаване до HTTP/1"
      ],
      correctEN: "Migrate backend to modern TLS and remove exceptions",
      correctBG: "Миграция на backend към модерен TLS и махане на изключенията",
      explanationEN: "Exceptions should be temporary. The durable fix is compliant TLS infrastructure so iOS can enforce secure defaults.",
      explanationBG: "Изключенията трябва да са временни. Устойчивото решение е backend с коректен TLS, за да работят сигурните стандарти по подразбиране."
    }
  },
  {
    beginner: {
      questionEN: "On iPad, users can open two windows of the same app. Which scene state callback tracks foreground activity per window?",
      questionBG: "На iPad потребителят може да отвори два прозореца на приложението. Кой callback следи foreground активността за всеки прозорец?",
      answersEN: [
        "sceneDidBecomeActive(_:)",
        "applicationDidBecomeActive(_:) only",
        "viewDidLoad",
        "didReceiveMemoryWarning"
      ],
      answersBG: [
        "sceneDidBecomeActive(_:)",
        "Само applicationDidBecomeActive(_:)",
        "viewDidLoad",
        "didReceiveMemoryWarning"
      ],
      correctEN: "sceneDidBecomeActive(_:)",
      correctBG: "sceneDidBecomeActive(_:)",
      explanationEN: "In multi-scene apps, activity is scene-specific. This callback reflects each window lifecycle independently.",
      explanationBG: "При multi-scene приложения активността е за конкретна scene. Този callback следи жизнения цикъл на всеки прозорец поотделно."
    },
    intermediate: {
      questionEN: "A draft editor should restore unsaved text when a scene reconnects. Which iOS feature is designed for this?",
      questionBG: "Редактор трябва да върне незапазен текст при повторно свързване на scene. Коя iOS възможност е предназначена за това?",
      answersEN: [
        "State restoration with scene session activities",
        "UIApplication.shared.windows",
        "Hardcoded global singleton",
        "Rebuild from logs"
      ],
      answersBG: [
        "State restoration със scene session activities",
        "UIApplication.shared.windows",
        "Глобален singleton",
        "Възстановяване от логове"
      ],
      correctEN: "State restoration with scene session activities",
      correctBG: "State restoration със scene session activities",
      explanationEN: "Scene activities persist context per session, enabling reliable restoration without leaking state across windows.",
      explanationBG: "Scene activities пазят контекст за всяка сесия и позволяват надеждно възстановяване без смесване между прозорци."
    },
    advanced: {
      questionEN: "Memory pressure spikes when three scenes are open. What architecture reduces cross-scene retention?",
      questionBG: "Паметта скача рязко при три отворени scene. Коя архитектура намалява задържането между scene-ите?",
      answersEN: [
        "Per-scene dependency container + shared immutable services",
        "Single giant mutable app singleton",
        "Duplicate caches per ViewController",
        "Disable multitasking support"
      ],
      answersBG: [
        "Контейнер по scene + споделени immutable услуги",
        "Един огромен mutable singleton",
        "Дублирани кешове във всеки ViewController",
        "Изключване на multitasking"
      ],
      correctEN: "Per-scene dependency container + shared immutable services",
      correctBG: "Контейнер по scene + споделени immutable услуги",
      explanationEN: "Scene-scoped mutable state prevents accidental retention across windows, while immutable shared services avoid duplication.",
      explanationBG: "Mutable състоянието по scene предотвратява неволно задържане между прозорци, а споделените immutable услуги избягват дублиране."
    }
  },
  {
    beginner: {
      questionEN: "A table view scroll stutters because every cell recreates image views. What basic UIKit rule helps first?",
      questionBG: "Скролът на table view насича, защото всеки cell създава наново image views. Кое базово UIKit правило помага първо?",
      answersEN: [
        "Reuse cells with proper reuse identifiers",
        "Call reloadData in scrollViewDidScroll",
        "Disable Auto Layout entirely",
        "Use one huge cell"
      ],
      answersBG: [
        "Преизползване на клетки с коректни reuse identifiers",
        "reloadData при всяко скрол събитие",
        "Пълно изключване на Auto Layout",
        "Една огромна клетка"
      ],
      correctEN: "Reuse cells with proper reuse identifiers",
      correctBG: "Преизползване на клетки с коректни reuse identifiers",
      explanationEN: "Cell reuse avoids repetitive allocation and layout work, which is critical for smooth scrolling.",
      explanationBG: "Преизползването на клетки спира излишните алокации и layout операции, което е ключово за плавен скрол."
    },
    intermediate: {
      questionEN: "Your feed updates one item but the whole table flashes. Which API update style avoids this?",
      questionBG: "Променя се само един елемент във feed-а, но цялата таблица премигва. Кой стил на обновяване го избягва?",
      answersEN: [
        "Diffable data source snapshot updates",
        "reloadData after every change",
        "Recreate table view controller",
        "Disable animations globally"
      ],
      answersBG: [
        "Snapshot обновяване с diffable data source",
        "reloadData след всяка промяна",
        "Създаване наново на контролера",
        "Глобално спиране на анимации"
      ],
      correctEN: "Diffable data source snapshot updates",
      correctBG: "Snapshot обновяване с diffable data source",
      explanationEN: "Diffable snapshots compute minimal inserts/deletes/moves, so only changed rows animate and redraw.",
      explanationBG: "Diffable snapshot изчислява минималните insert/delete/move промени, затова се обновяват само нужните редове."
    },
    advanced: {
      questionEN: "A mixed UIKit/SwiftUI feed causes expensive self-sizing passes. What gives deterministic height performance?",
      questionBG: "Смесен UIKit/SwiftUI feed прави скъпи self-sizing pass-ове. Какво дава детерминирана производителност на височините?",
      answersEN: [
        "Precomputed layout metrics + estimatedRowHeight tuning",
        "Always return UITableView.automaticDimension",
        "Force synchronous image decoding on main",
        "Disable dynamic type"
      ],
      answersBG: [
        "Предварително сметнати размери + tuning на estimatedRowHeight",
        "Винаги automaticDimension",
        "Синхронно декодиране на изображения на main thread",
        "Изключване на Dynamic Type"
      ],
      correctEN: "Precomputed layout metrics + estimatedRowHeight tuning",
      correctBG: "Предварително сметнати размери + tuning на estimatedRowHeight",
      explanationEN: "Stable estimates and precomputed metrics reduce relayout churn, especially when hosting complex nested content.",
      explanationBG: "Стабилните оценки и предварително сметнати размери намаляват relayout натоварването, особено при сложни вложени компоненти."
    }
  },
  {
    beginner: {
      questionEN: "A button is off-screen on smaller iPhones in portrait. Which layout approach is correct?",
      questionBG: "Бутон излиза извън екрана на по-малки iPhone-и в portrait. Кой layout подход е правилен?",
      answersEN: [
        "Constrain to safe area with adaptive constraints",
        "Set one fixed frame for all devices",
        "Use only autoresizing masks",
        "Hardcode iPhone 15 Pro size"
      ],
      answersBG: [
        "Ограничения към safe area с адаптивни constraints",
        "Един фиксиран frame за всички устройства",
        "Само autoresizing masks",
        "Твърд размер за iPhone 15 Pro"
      ],
      correctEN: "Constrain to safe area with adaptive constraints",
      correctBG: "Ограничения към safe area с адаптивни constraints",
      explanationEN: "Safe-area-based constraints adapt to notches, bars, and screen sizes while preserving intended spacing.",
      explanationBG: "Ограниченията към safe area се адаптират към notch, системни ленти и различни размери, като пазят правилните отстояния."
    },
    intermediate: {
      questionEN: "A runtime warning says constraints are ambiguous only in Arabic locale. What should you change first?",
      questionBG: "Runtime предупреждение за ambiguous constraints се появява само на арабски език. Какво променяш първо?",
      answersEN: [
        "Use leading/trailing instead of left/right constraints",
        "Disable localization for Arabic",
        "Set all labels to one line",
        "Force LTR globally"
      ],
      answersBG: [
        "Използвай leading/trailing вместо left/right",
        "Изключи арабската локализация",
        "Едноредови labels навсякъде",
        "Глобално принудително LTR"
      ],
      correctEN: "Use leading/trailing instead of left/right constraints",
      correctBG: "Използвай leading/trailing вместо left/right",
      explanationEN: "RTL locales flip horizontal direction. Leading/trailing constraints are semantic and adapt automatically.",
      explanationBG: "RTL локалите обръщат хоризонталната посока. Leading/trailing са семантични и се адаптират автоматично."
    },
    advanced: {
      questionEN: "An onboarding screen has complex constraints and takes 20ms/layout pass. What optimization is most effective?",
      questionBG: "Onboarding екранът има сложни constraints и отнема 20ms на layout pass. Коя оптимизация е най-ефективна?",
      answersEN: [
        "Flatten hierarchy and reduce constraint graph complexity",
        "Call layoutIfNeeded repeatedly",
        "Disable Auto Layout in release builds",
        "Use random priorities"
      ],
      answersBG: [
        "Оптимизирай йерархията и намали сложността на constraint графа",
        "Многократно layoutIfNeeded",
        "Изключи Auto Layout в release",
        "Случайни приоритети"
      ],
      correctEN: "Flatten hierarchy and reduce constraint graph complexity",
      correctBG: "Оптимизирай йерархията и намали сложността на constraint графа",
      explanationEN: "Solver cost scales with graph complexity. Fewer nested containers and cleaner constraints produce measurable layout gains.",
      explanationBG: "Цената на solver-а расте със сложността на графа. По-плоска йерархия и по-чисти ограничения дават реално ускорение."
    }
  },
  {
    beginner: {
      questionEN: "A quote app must keep user favorites after reinstall from iCloud backup. Which storage fits best?",
      questionBG: "Приложение за цитати трябва да пази любими и след преинсталация от iCloud backup. Кое хранилище е най-подходящо?",
      answersEN: [
        "Core Data store in app container",
        "Temporary directory",
        "In-memory array only",
        "UILabel accessibilityHint"
      ],
      answersBG: [
        "Core Data хранилище в app контейнера",
        "Temporary директория",
        "Само in-memory масив",
        "UILabel accessibilityHint"
      ],
      correctEN: "Core Data store in app container",
      correctBG: "Core Data хранилище в app контейнера",
      explanationEN: "Persistent app data belongs in a durable store. Core Data provides schema, migration, and efficient fetch support.",
      explanationBG: "Постоянните данни трябва да са в устойчиво хранилище. Core Data дава схема, миграции и ефективни заявки."
    },
    intermediate: {
      questionEN: "Saving on every keystroke causes jank in a Core Data form. What is the better pattern?",
      questionBG: "Запис при всяко натискане на клавиш води до засичане в Core Data форма. Кой е по-добрият модел?",
      answersEN: [
        "Edit in child context, save in batches",
        "Call save() in textFieldDidChange always",
        "Move all saves to main thread sync",
        "Disable undo manager permanently"
      ],
      answersBG: [
        "Редакция в child context и пакетен save",
        "Винаги save() при промяна на текста",
        "Синхронни save операции на main thread",
        "Постоянно изключен undo manager"
      ],
      correctEN: "Edit in child context, save in batches",
      correctBG: "Редакция в child context и пакетен save",
      explanationEN: "Batching reduces disk writes and merge churn. Child contexts isolate edits until the user commits meaningful changes.",
      explanationBG: "Пакетният запис намалява дисковите операции и конфликтите при merge. Child context изолира редакциите до смислено потвърждение."
    },
    advanced: {
      questionEN: "Two background imports create duplicate products because IDs differ by case. What durable data rule fixes this?",
      questionBG: "Два background import процеса създават дублирани продукти, защото ID-та се различават по главни/малки букви. Кое правило решава трайно проблема?",
      answersEN: [
        "Canonicalize IDs + unique constraints in Core Data model",
        "Compare objects by pointer address",
        "Delete all rows before every import",
        "Import only on first launch"
      ],
      answersBG: [
        "Канонизиране на ID + unique constraints в Core Data модела",
        "Сравнение по pointer адрес",
        "Изтриване на всички редове преди всеки import",
        "Import само при първо стартиране"
      ],
      correctEN: "Canonicalize IDs + unique constraints in Core Data model",
      correctBG: "Канонизиране на ID + unique constraints в Core Data модела",
      explanationEN: "Canonical keys prevent logical duplicates, and unique constraints enforce integrity even under concurrent writes.",
      explanationBG: "Каноничните ключове спират логическите дубликати, а unique constraints пазят целостта дори при конкурентни записи."
    }
  },
  {
    beginner: {
      questionEN: "After archive upload, testers cannot install because no build appears in TestFlight. What is usually missing first?",
      questionBG: "След качен архив тестерите не могат да инсталират, защото няма build в TestFlight. Какво най-често липсва първо?",
      answersEN: [
        "Wait for App Store Connect processing to finish",
        "Delete provisioning profiles",
        "Remove app icon",
        "Turn off bitcode manually"
      ],
      answersBG: [
        "Изчакай processing-а в App Store Connect",
        "Изтрий provisioning профилите",
        "Премахни иконата на приложението",
        "Изключи ръчно bitcode"
      ],
      correctEN: "Wait for App Store Connect processing to finish",
      correctBG: "Изчакай processing-а в App Store Connect",
      explanationEN: "Uploaded builds are not immediately testable. They must finish server-side processing before appearing for testers.",
      explanationBG: "Каченият build не става веднага достъпен. Трябва да завърши server-side обработката, преди да се покаже на тестерите."
    },
    intermediate: {
      questionEN: "Internal testers see the build, external testers do not. What gate likely blocks rollout?",
      questionBG: "Вътрешните тестери виждат build-а, външните не го виждат. Коя стъпка най-вероятно блокира разпространението?",
      answersEN: [
        "Beta App Review approval",
        "Device UDID registration",
        "Xcode DerivedData cleanup",
        "New App ID creation"
      ],
      answersBG: [
        "Одобрение от Beta App Review",
        "Регистрация на UDID устройства",
        "Изчистване на DerivedData",
        "Създаване на нов App ID"
      ],
      correctEN: "Beta App Review approval",
      correctBG: "Одобрение от Beta App Review",
      explanationEN: "External groups require Beta App Review for most builds. Internal testing does not, which explains the mismatch.",
      explanationBG: "За външни групи обикновено е нужно Beta App Review, а за вътрешни не е. Затова се получава това разминаване."
    },
    advanced: {
      questionEN: "Crash rate rose after phased rollout to 25%. What release control lets you stop spread without removing the app?",
      questionBG: "След phased rollout до 25% crash rate се покачи. Кой контрол позволява да спреш разпространението без да сваляш приложението?",
      answersEN: [
        "Pause phased release in App Store Connect",
        "Delete app from store permanently",
        "Force-update all users via push",
        "Disable symbol uploads"
      ],
      answersBG: [
        "Пауза на phased release в App Store Connect",
        "Постоянно изтриване от магазина",
        "Принудителен update чрез push",
        "Спиране на symbol upload"
      ],
      correctEN: "Pause phased release in App Store Connect",
      correctBG: "Пауза на phased release в App Store Connect",
      explanationEN: "Phased release controls exposure. Pausing limits new installs while you investigate and ship a fixed build.",
      explanationBG: "Phased release контролира обхвата. Пауза ограничава новите инсталации, докато разследваш и пуснеш коригиран build."
    }
  },
  {
    beginner: {
      questionEN: "VoiceOver reads 'button' with no context for a trash icon. Which accessibility property should be set first?",
      questionBG: "VoiceOver чете само „button“ за икона кошче. Кое accessibility свойство задаваш първо?",
      answersEN: [
        "accessibilityLabel",
        "tintColor",
        "contentMode",
        "shadowOpacity"
      ],
      answersBG: [
        "accessibilityLabel",
        "tintColor",
        "contentMode",
        "shadowOpacity"
      ],
      correctEN: "accessibilityLabel",
      correctBG: "accessibilityLabel",
      explanationEN: "Icon-only controls need a spoken label describing action. Without it, assistive technologies announce generic, useless output.",
      explanationBG: "Иконните бутони имат нужда от ясно spoken име на действието. Без него помощните технологии дават обща и безполезна информация."
    },
    intermediate: {
      questionEN: "A custom slider is announced but users cannot understand current value. What should you add?",
      questionBG: "Custom slider се обявява, но потребителят не разбира текущата стойност. Какво трябва да добавиш?",
      answersEN: [
        "accessibilityValue updates",
        "More visual gradients",
        "Bigger corner radius",
        "Disable haptics"
      ],
      answersBG: [
        "Обновяване на accessibilityValue",
        "Повече визуални градиенти",
        "По-голям радиус на ъглите",
        "Изключване на haptics"
      ],
      correctEN: "accessibilityValue updates",
      correctBG: "Обновяване на accessibilityValue",
      explanationEN: "Controls with continuous state must expose their current value to VoiceOver. Otherwise users can act but not verify result.",
      explanationBG: "Контролите с непрекъснато състояние трябва да съобщават текущата стойност към VoiceOver. Иначе има действие без проверим резултат."
    },
    advanced: {
      questionEN: "Finance screen has 120 elements and swipe navigation is exhausting. Which feature improves expert navigation?",
      questionBG: "Финансов екран има 120 елемента и навигацията със swipe е изтощителна. Коя функция подобрява експертната навигация?",
      answersEN: [
        "Custom accessibility rotor",
        "Increase font to 40pt always",
        "Hide all separators",
        "Disable Dynamic Type"
      ],
      answersBG: [
        "Custom accessibility rotor",
        "Винаги шрифт 40pt",
        "Скриване на всички разделители",
        "Изключване на Dynamic Type"
      ],
      correctEN: "Custom accessibility rotor",
      correctBG: "Custom accessibility rotor",
      explanationEN: "Rotors provide fast jumps between meaningful categories (errors, totals, headers), drastically reducing gesture fatigue.",
      explanationBG: "Rotor позволява бързи скокове между смислени групи (грешки, суми, заглавия) и силно намалява умората от жестове."
    }
  },
  {
    beginner: {
      questionEN: "The app mixes English and Bulgarian text on one screen. Where should UI strings live?",
      questionBG: "На един екран има смесени английски и български текстове. Къде трябва да са UI низовете?",
      answersEN: [
        "Localizable.strings",
        "Hardcoded in storyboard labels",
        "README.md",
        "App Store subtitle"
      ],
      answersBG: [
        "Localizable.strings",
        "Твърдо кодирани в storyboard",
        "README.md",
        "Подзаглавие в App Store"
      ],
      correctEN: "Localizable.strings",
      correctBG: "Localizable.strings",
      explanationEN: "Localized resource files centralize translations and let iOS pick language at runtime automatically.",
      explanationBG: "Локализираните ресурсни файлове централизират преводите и позволяват iOS автоматично да избира езика по време на изпълнение."
    },
    intermediate: {
      questionEN: "Prices localize incorrectly because decimal separators stay US-style. Which API should format them?",
      questionBG: "Цените се локализират грешно, защото десетичният разделител остава по US стандарт. Кой API трябва да форматира стойностите?",
      answersEN: [
        "NumberFormatter with locale-aware style",
        "String interpolation only",
        "Manual replace of '.' and ','",
        "URLComponents"
      ],
      answersBG: [
        "NumberFormatter с locale-aware стил",
        "Само string interpolation",
        "Ръчна замяна на '.' и ','",
        "URLComponents"
      ],
      correctEN: "NumberFormatter with locale-aware style",
      correctBG: "NumberFormatter с locale-aware стил",
      explanationEN: "Formatting rules vary by locale and currency. NumberFormatter applies correct separators, grouping, and symbols.",
      explanationBG: "Правилата за формат са различни по локал и валута. NumberFormatter прилага правилните разделители, групиране и символи."
    },
    advanced: {
      questionEN: "Arabic layout truncates long CTA text despite translations being present. What process prevents this regression?",
      questionBG: "В арабския интерфейс дълъг CTA текст се реже, въпреки че преводите съществуват. Кой процес предотвратява такава регресия?",
      answersEN: [
        "Pseudo-localization + RTL snapshot tests in CI",
        "Shorten all texts to one word",
        "Disable Arabic support",
        "Use fixed-width labels"
      ],
      answersBG: [
        "Pseudo-localization + RTL snapshot тестове в CI",
        "Съкрати всички текстове до една дума",
        "Изключи Arabic поддръжка",
        "Фиксирана ширина на labels"
      ],
      correctEN: "Pseudo-localization + RTL snapshot tests in CI",
      correctBG: "Pseudo-localization + RTL snapshot тестове в CI",
      explanationEN: "Pseudo-locales stress length/RTL issues early. Automated snapshots catch visual breakage before release.",
      explanationBG: "Pseudo-локалите разкриват рано проблеми с дължина и RTL. Автоматичните snapshot тестове хващат визуални счупвания преди release."
    }
  },
  {
    beginner: {
      questionEN: "A gallery screen gets memory warnings after scrolling many photos. What should be released first?",
      questionBG: "Галерията получава memory warning след дълъг скрол на снимки. Какво трябва да освободиш първо?",
      answersEN: [
        "In-memory image cache not currently visible",
        "Core app constants",
        "Navigation title",
        "Bundle identifier"
      ],
      answersBG: [
        "In-memory кеш на невидимите изображения",
        "Основни константи на приложението",
        "Навигационно заглавие",
        "Bundle identifier"
      ],
      correctEN: "In-memory image cache not currently visible",
      correctBG: "In-memory кеш на невидимите изображения",
      explanationEN: "Large image caches are common memory pressure sources. Evicting non-visible assets quickly lowers footprint.",
      explanationBG: "Големите image кешове често са причината за натиск върху паметта. Изчистването на невидимите ресурси намалява usage-а бързо."
    },
    intermediate: {
      questionEN: "An object graph never deallocates after leaving screen. Which tool reveals retain cycles fastest?",
      questionBG: "Обектната графика не се освобождава след напускане на екран. Кой инструмент най-бързо показва retain цикли?",
      answersEN: [
        "Xcode Memory Graph Debugger",
        "Simulator keyboard shortcuts",
        "Asset Catalog inspector",
        "Info.plist editor"
      ],
      answersBG: [
        "Xcode Memory Graph Debugger",
        "Клавишни комбинации в симулатора",
        "Asset Catalog inspector",
        "Info.plist редактор"
      ],
      correctEN: "Xcode Memory Graph Debugger",
      correctBG: "Xcode Memory Graph Debugger",
      explanationEN: "Memory Graph visualizes ownership chains and leaked objects, making retain cycles directly inspectable.",
      explanationBG: "Memory Graph визуализира връзките на собственост и изтеклите обекти, така че retain циклите се виждат директно."
    },
    advanced: {
      questionEN: "A chat app leaks view models after repeated open/close cycles. What coding pattern usually prevents this?",
      questionBG: "Chat приложение изтича view model-и при многократно отваряне/затваряне. Кой coding pattern най-често предотвратява това?",
      answersEN: [
        "Weak captures in closures and explicit observer removal",
        "Use more singletons",
        "Disable ARC with unmanaged objects",
        "Keep all subscriptions global"
      ],
      answersBG: [
        "Weak capture в closure-и и явна дерегистрация на observer-и",
        "Повече singleton-и",
        "Изключване на ARC с unmanaged обекти",
        "Глобални subscriptions навсякъде"
      ],
      correctEN: "Weak captures in closures and explicit observer removal",
      correctBG: "Weak capture в closure-и и явна дерегистрация на observer-и",
      explanationEN: "Leaks often come from closure/subscription ownership loops. Weak captures and deterministic teardown break those cycles.",
      explanationBG: "Течовете често идват от цикли в closure-и и subscriptions. Weak capture и детерминирано освобождаване прекъсват тези цикли."
    }
  },
  {
    beginner: {
      questionEN: "Users complain the download size is too large on cellular. Which iOS distribution feature helps reduce app package per device?",
      questionBG: "Потребителите се оплакват, че размерът за сваляне е твърде голям по мобилна мрежа. Коя iOS функция намалява пакета според устройството?",
      answersEN: [
        "App Thinning",
        "Universal clipboard",
        "Background fetch",
        "Push token refresh"
      ],
      answersBG: [
        "App Thinning",
        "Universal clipboard",
        "Background fetch",
        "Push token refresh"
      ],
      correctEN: "App Thinning",
      correctBG: "App Thinning",
      explanationEN: "App Thinning delivers only relevant architectures/resources to each device, reducing install and download size.",
      explanationBG: "App Thinning доставя само нужните архитектури и ресурси за конкретното устройство, което намалява размера за инсталиране."
    },
    intermediate: {
      questionEN: "A huge tutorial video is needed only for first-time users. Which delivery mechanism keeps initial IPA small?",
      questionBG: "Голямо tutorial видео е нужно само за нови потребители. Кой механизъм държи началния IPA малък?",
      answersEN: [
        "On-Demand Resources",
        "Embed video in LaunchScreen",
        "Store video in Info.plist",
        "Ship all videos in Assets always"
      ],
      answersBG: [
        "On-Demand Resources",
        "Видео в LaunchScreen",
        "Видео в Info.plist",
        "Всички видеа винаги в Assets"
      ],
      correctEN: "On-Demand Resources",
      correctBG: "On-Demand Resources",
      explanationEN: "ODR defers large assets until needed, reducing initial download while still allowing dynamic retrieval.",
      explanationBG: "ODR отлага големите ресурси до момента на нужда, намалява първоначалния download и позволява динамично зареждане."
    },
    advanced: {
      questionEN: "Your app ships many localized image packs; some users never switch language. How do you cut wasted storage post-install?",
      questionBG: "Приложението съдържа много локализирани image пакети, а част от потребителите никога не сменят езика. Как намаляваш излишното място след инсталация?",
      answersEN: [
        "Tag assets and manage ODR eviction priorities",
        "Store all packs in Documents permanently",
        "Disable localization",
        "Compress PNG by renaming extension"
      ],
      answersBG: [
        "Tag-ване на assets и управление на ODR eviction приоритети",
        "Постоянно пазене на всички пакети в Documents",
        "Изключване на локализация",
        "Компресиране чрез преименуване на разширение"
      ],
      correctEN: "Tag assets and manage ODR eviction priorities",
      correctBG: "Tag-ване на assets и управление на ODR eviction приоритети",
      explanationEN: "ODR tags plus eviction control keep frequently used resources and discard rarely used packs safely.",
      explanationBG: "ODR таговете и контролът на eviction пазят често използваните ресурси и освобождават рядко нужните пакети."
    }
  },
  {
    beginner: {
      questionEN: "Universal links open Safari instead of your app. Which server file is usually misconfigured?",
      questionBG: "Universal link отваря Safari вместо приложението. Кой сървърен файл най-често е конфигуриран грешно?",
      answersEN: [
        "apple-app-site-association",
        "robots.txt",
        "sitemap.xml",
        "package-lock.json"
      ],
      answersBG: [
        "apple-app-site-association",
        "robots.txt",
        "sitemap.xml",
        "package-lock.json"
      ],
      correctEN: "apple-app-site-association",
      correctBG: "apple-app-site-association",
      explanationEN: "iOS verifies universal link ownership via this file. Wrong content-type/path/signing prevents app routing.",
      explanationBG: "iOS валидира ownership на universal links чрез този файл. Грешен content-type/път/подпис спира отварянето в приложението."
    },
    intermediate: {
      questionEN: "A user taps two deep links quickly and navigation state corrupts. What app-side protection should exist?",
      questionBG: "Потребител натиска два deep link-а бързо и навигационното състояние се поврежда. Каква защита трябва да има в приложението?",
      answersEN: [
        "Idempotent deep-link handler with queueing",
        "Navigate immediately from any thread",
        "Disable all links after first tap forever",
        "Open only home screen always"
      ],
      answersBG: [
        "Idempotent deep-link handler с опашка",
        "Незабавна навигация от произволен thread",
        "Постоянно спиране на линковете след първо натискане",
        "Винаги отваряй само home екран"
      ],
      correctEN: "Idempotent deep-link handler with queueing",
      correctBG: "Idempotent deep-link handler с опашка",
      explanationEN: "Queueing and idempotency prevent overlapping transitions and duplicate side effects from rapid repeated links.",
      explanationBG: "Опашка и идемпотентност спират припокриващи се преходи и дублирани действия при бързи повторни натискания."
    },
    advanced: {
      questionEN: "Some links should open in-app only when user is authenticated with specific role. What design keeps this secure?",
      questionBG: "Някои линкове трябва да се отварят в приложението само при логнат потребител с конкретна роля. Кой дизайн е сигурен?",
      answersEN: [
        "Route guards that validate auth + authorization before navigation",
        "Hide protected screens in UI only",
        "Trust link source completely",
        "Check role only after API mutation"
      ],
      answersBG: [
        "Route guard-и с проверка на auth + authorization преди навигация",
        "Скриване на екраните само визуално",
        "Пълно доверие на източника на линка",
        "Проверка на роля чак след API mutation"
      ],
      correctEN: "Route guards that validate auth + authorization before navigation",
      correctBG: "Route guard-и с проверка на auth + authorization преди навигация",
      explanationEN: "Navigation must enforce the same security policy as backend operations. Pre-navigation guards prevent unauthorized screen access.",
      explanationBG: "Навигацията трябва да налага същата политика като backend операциите. Guard проверките преди преход спират неоторизиран достъп."
    }
  },
  {
    beginner: {
      questionEN: "Background refresh never runs on real devices, but works in simulator. Which app setup is often missing?",
      questionBG: "Background refresh не тръгва на реални устройства, но работи в симулатор. Коя настройка често липсва?",
      answersEN: [
        "Background Modes capability",
        "App icon in 1024px",
        "LaunchScreen animation",
        "Custom URL scheme"
      ],
      answersBG: [
        "Background Modes capability",
        "Икона 1024px",
        "Анимация в LaunchScreen",
        "Custom URL scheme"
      ],
      correctEN: "Background Modes capability",
      correctBG: "Background Modes capability",
      explanationEN: "Without enabled background capabilities, the system will not schedule many background tasks on device.",
      explanationBG: "Без включени background capabilities системата няма да насрочва много фонови задачи на реално устройство."
    },
    intermediate: {
      questionEN: "A periodic content sync should run opportunistically without draining battery. Which API is preferred?",
      questionBG: "Периодична синхронизация трябва да се изпълнява опортюнистично без излишен разход на батерия. Кой API е предпочитан?",
      answersEN: [
        "BGAppRefreshTaskRequest",
        "Timer every 60 seconds in background",
        "Infinite audio playback hack",
        "Push local notification loop"
      ],
      answersBG: [
        "BGAppRefreshTaskRequest",
        "Timer на 60 секунди във фон",
        "Хак с безкраен audio playback",
        "Цикъл с локални нотификации"
      ],
      correctEN: "BGAppRefreshTaskRequest",
      correctBG: "BGAppRefreshTaskRequest",
      explanationEN: "BGAppRefreshTask lets iOS schedule work at efficient times based on device conditions.",
      explanationBG: "BGAppRefreshTask позволява iOS да насрочи задачата в подходящ момент според състоянието на устройството."
    },
    advanced: {
      questionEN: "A long import is killed mid-way in background and data becomes inconsistent. What resilience pattern should be used?",
      questionBG: "Дълъг import във фон се прекъсва по средата и данните стават непоследователни. Кой устойчив pattern трябва да се използва?",
      answersEN: [
        "Checkpointed idempotent jobs with resumable progress",
        "Single giant transaction only",
        "Disable task expiration handlers",
        "Ignore partial writes"
      ],
      answersBG: [
        "Checkpoint-нати идемпотентни задачи с възстановим прогрес",
        "Една огромна транзакция",
        "Изключване на expiration handler",
        "Игнориране на частични записи"
      ],
      correctEN: "Checkpointed idempotent jobs with resumable progress",
      correctBG: "Checkpoint-нати идемпотентни задачи с възстановим прогрес",
      explanationEN: "Background execution can end anytime. Checkpoints + idempotency ensure safe resume without data corruption.",
      explanationBG: "Фоновото изпълнение може да бъде спряно по всяко време. Checkpoint + идемпотентност позволяват безопасно продължаване без повреждане на данни."
    }
  },
  {
    beginner: {
      questionEN: "A release build crashes immediately on launch, but debug is fine. Which first artifact helps find the cause?",
      questionBG: "Release build се срива веднага при старт, а debug работи. Кой артефакт първо помага за причината?",
      answersEN: [
        "Crash report with symbolicated stack trace",
        "Storyboard XML comments",
        "App icon set",
        "README badges"
      ],
      answersBG: [
        "Crash report със symbolicated stack trace",
        "XML коментари в storyboard",
        "Иконен сет на приложението",
        "README badges"
      ],
      correctEN: "Crash report with symbolicated stack trace",
      correctBG: "Crash report със symbolicated stack trace",
      explanationEN: "Symbolicated crash stacks show the exact failing function and call path, which is essential for release-only crashes.",
      explanationBG: "Символикираният crash stack показва точната функция и път на извикване, което е критично при release-only сривове."
    },
    intermediate: {
      questionEN: "Crash logs show hex addresses because symbols are missing in CI artifacts. What must be preserved?",
      questionBG: "Crash логовете показват hex адреси, защото липсват символи от CI. Какво задължително трябва да се пази?",
      answersEN: [
        "Matching dSYM files per build",
        "Only .ipa file",
        "Only Info.plist",
        "Only App Store screenshots"
      ],
      answersBG: [
        "Съответните dSYM файлове за всеки build",
        "Само .ipa файл",
        "Само Info.plist",
        "Само App Store screenshot-и"
      ],
      correctEN: "Matching dSYM files per build",
      correctBG: "Съответните dSYM файлове за всеки build",
      explanationEN: "Without matching dSYMs, addresses cannot map to symbols. Reliable symbolication depends on exact build artifacts.",
      explanationBG: "Без точните dSYM файлове адресите не могат да се преведат в символи. Надеждната символикация зависи от артефактите на конкретния build."
    },
    advanced: {
      questionEN: "A native crash appears only under heavy load in production. Which observability setup shortens time-to-fix most?",
      questionBG: "Native crash се появява само при голямо натоварване в production. Коя observability конфигурация най-много съкращава времето за fix?",
      answersEN: [
        "OSLog signposts + crash breadcrumbs + build metadata correlation",
        "Print statements only",
        "Disable crash reporting",
        "Collect logs manually from users once"
      ],
      answersBG: [
        "OSLog signpost-и + crash breadcrumbs + корелация с build metadata",
        "Само print изрази",
        "Изключване на crash reporting",
        "Еднократно ръчно събиране на логове"
      ],
      correctEN: "OSLog signposts + crash breadcrumbs + build metadata correlation",
      correctBG: "OSLog signpost-и + crash breadcrumbs + корелация с build metadata",
      explanationEN: "Correlated runtime traces around the crash window provide causality, not just the final crash frame.",
      explanationBG: "Корелираните runtime следи около момента на срива дават причинно-следствена картина, а не само последния кадър от stack-а."
    }
  },
  {
    beginner: {
      questionEN: "An image-heavy feed drains battery during scrolling. Which quick optimization is usually valid?",
      questionBG: "Feed с много изображения изтощава батерията при скрол. Коя бърза оптимизация обикновено е валидна?",
      answersEN: [
        "Decode and resize images off the main thread",
        "Increase screen brightness in app",
        "Disable reuse identifiers",
        "Use PNG for every photo"
      ],
      answersBG: [
        "Decode и resize на изображения извън main thread",
        "Повиши яркостта в приложението",
        "Изключи reuse identifiers",
        "PNG за всяка снимка"
      ],
      correctEN: "Decode and resize images off the main thread",
      correctBG: "Decode и resize на изображения извън main thread",
      explanationEN: "Off-main decoding prevents UI stalls and reduces repeated GPU/CPU work while scrolling.",
      explanationBG: "Декодирането извън main thread спира засичането на UI и намалява повтарящото се GPU/CPU натоварване при скрол."
    },
    intermediate: {
      questionEN: "A startup takes 2.8s before first interactive frame. Which instrument should quantify launch phases?",
      questionBG: "Стартирането отнема 2.8 секунди до първи интерактивен кадър. Кой инструмент измерва фазите на launch-а?",
      answersEN: [
        "Instruments Time Profiler + App Launch template",
        "Only XCTest assertions",
        "Simulator slow animations",
        "App Store Connect screenshots"
      ],
      answersBG: [
        "Instruments Time Profiler + App Launch template",
        "Само XCTest assertions",
        "Slow animations в симулатора",
        "App Store Connect screenshots"
      ],
      correctEN: "Instruments Time Profiler + App Launch template",
      correctBG: "Instruments Time Profiler + App Launch template",
      explanationEN: "Launch profiling isolates pre-main, app init, and first-frame costs, so optimization targets are evidence-based.",
      explanationBG: "Профилирането на launch-а отделя pre-main, инициализация и first-frame разходите, така че оптимизацията стъпва на данни."
    },
    advanced: {
      questionEN: "You need continuous regression detection for startup and scrolling performance in CI. What setup works best?",
      questionBG: "Трябва непрекъснато засичане на регресии в стартиране и скрол производителност в CI. Коя настройка работи най-добре?",
      answersEN: [
        "Performance baselines with XCTMetric and threshold alerts",
        "Manual QA once before release",
        "Disable tests on Mondays",
        "Average user ratings only"
      ],
      answersBG: [
        "Performance baseline-и с XCTMetric и аларми по праг",
        "Ръчен QA само преди release",
        "Изключване на тестове в понеделник",
        "Само среден рейтинг от потребители"
      ],
      correctEN: "Performance baselines with XCTMetric and threshold alerts",
      correctBG: "Performance baseline-и с XCTMetric и аларми по праг",
      explanationEN: "Automated performance baselines catch drift early and make regressions actionable before users feel them.",
      explanationBG: "Автоматизираните baseline-и хващат отклоненията рано и правят регресиите поправими преди да засегнат потребителите."
    }
  },
  {
    beginner: {
      questionEN: "A banking app must not expose customer profile data in screenshots shown in app switcher. What should you use?",
      questionBG: "Банково приложение не трябва да показва клиентски данни в snapshot-а на app switcher. Какво трябва да използваш?",
      answersEN: [
        "Blur/cover sensitive UI when app enters background",
        "Disable multitasking globally",
        "Crash app on backgrounding",
        "Hide status bar only"
      ],
      answersBG: [
        "Замъгляване/покриване на чувствителния UI при background",
        "Глобално изключване на multitasking",
        "Срив на приложението при background",
        "Скриване само на status bar"
      ],
      correctEN: "Blur/cover sensitive UI when app enters background",
      correctBG: "Замъгляване/покриване на чувствителния UI при background",
      explanationEN: "The system snapshot is taken during background transition. Covering sensitive content protects user privacy.",
      explanationBG: "Системният snapshot се прави при преминаване към background. Покриването на чувствителното съдържание пази поверителността."
    },
    intermediate: {
      questionEN: "Security policy requires jailbreak signal handling before enabling transfers. Where should this decision live?",
      questionBG: "Политиката за сигурност изисква проверка за jailbreak преди активиране на преводи. Къде трябва да живее това решение?",
      answersEN: [
        "In a centralized security gate/service layer",
        "Inside every UIButton action",
        "Only in unit tests",
        "In Localizable.strings"
      ],
      answersBG: [
        "В централизиран security gate/service слой",
        "Във всеки UIButton action",
        "Само в unit тестове",
        "В Localizable.strings"
      ],
      correctEN: "In a centralized security gate/service layer",
      correctBG: "В централизиран security gate/service слой",
      explanationEN: "Centralized enforcement keeps policy consistent across screens and prevents bypass through unprotected flows.",
      explanationBG: "Централизираното налагане държи политиката еднаква за всички екрани и предотвратява заобикаляне през незащитени пътища."
    },
    advanced: {
      questionEN: "PCI review asks for auditability of every privileged in-app operation. What implementation is strongest?",
      questionBG: "PCI преглед изисква пълна проследимост на всяка привилегирована операция в приложението. Коя имплементация е най-силна?",
      answersEN: [
        "Signed audit events with user/session context and immutable backend logs",
        "Console prints in release",
        "Store logs only on device",
        "Sample 1% of operations randomly"
      ],
      answersBG: [
        "Подписани audit събития с user/session контекст и immutable backend логове",
        "Console print-ове в release",
        "Логове само локално на устройството",
        "Случайна извадка от 1%"
      ],
      correctEN: "Signed audit events with user/session context and immutable backend logs",
      correctBG: "Подписани audit събития с user/session контекст и immutable backend логове",
      explanationEN: "Compliance needs integrity, traceability, and non-repudiation. Signed immutable audit trails provide all three.",
      explanationBG: "Compliance изисква целостност, проследимост и неотричаемост. Подписаните неизменяеми audit следи дават и трите."
    }
  },
  {
    beginner: {
      questionEN: "A UIKit app starts migrating one feature to SwiftUI. What is a safe integration entry point?",
      questionBG: "UIKit приложение мигрира една функционалност към SwiftUI. Коя е безопасната входна точка за интеграция?",
      answersEN: [
        "UIHostingController for isolated screen",
        "Rewrite entire app in one commit",
        "Embed SwiftUI in AppDelegate only",
        "Disable navigation controller"
      ],
      answersBG: [
        "UIHostingController за изолиран екран",
        "Пренаписване на всичко в един commit",
        "SwiftUI само в AppDelegate",
        "Изключване на navigation controller"
      ],
      correctEN: "UIHostingController for isolated screen",
      correctBG: "UIHostingController за изолиран екран",
      explanationEN: "Hosting one screen at a time reduces migration risk and allows incremental validation in production.",
      explanationBG: "Хостването на отделен екран намалява риска и позволява поетапна проверка при реални потребители."
    },
    intermediate: {
      questionEN: "State gets duplicated between UIKit controller and SwiftUI view model. What contract avoids this?",
      questionBG: "Състоянието се дублира между UIKit контролер и SwiftUI view model. Какъв договор избягва това?",
      answersEN: [
        "Single source of truth with unidirectional data flow",
        "Mirror every field in both layers",
        "Use notifications for everything",
        "Store state in view tags"
      ],
      answersBG: [
        "Single source of truth с еднопосочен поток на данни",
        "Огледално копие на всяко поле",
        "Нотификации за всичко",
        "Състояние във view tag-ове"
      ],
      correctEN: "Single source of truth with unidirectional data flow",
      correctBG: "Single source of truth с еднопосочен поток на данни",
      explanationEN: "A single owner for mutable state eliminates divergence and makes updates predictable across frameworks.",
      explanationBG: "Един собственик на mutable състоянието премахва разминаванията и прави обновяванията предвидими между двата UI свята."
    },
    advanced: {
      questionEN: "Hybrid navigation produces inconsistent back behavior across UIKit and SwiftUI stacks. What architecture resolves this cleanly?",
      questionBG: "Хибридната навигация дава непоследователно поведение на бутона назад между UIKit и SwiftUI. Коя архитектура решава чисто проблема?",
      answersEN: [
        "Coordinator owning cross-framework navigation state",
        "Separate independent stacks with no sync",
        "Global static currentScreen string",
        "Avoid deep links entirely"
      ],
      answersBG: [
        "Coordinator, който държи навигационното състояние между двата framework-а",
        "Два независими стека без синхрон",
        "Глобален static currentScreen низ",
        "Пълно избягване на deep links"
      ],
      correctEN: "Coordinator owning cross-framework navigation state",
      correctBG: "Coordinator, който държи навигационното състояние между двата framework-а",
      explanationEN: "A coordinator provides one navigation authority, preventing stack drift and ensuring consistent back semantics.",
      explanationBG: "Coordinator дава един източник на истина за навигацията, предотвратява разминавания на стековете и осигурява консистентно поведение назад."
    }
  },
  {
    beginner: {
      questionEN: "A feature works in simulator but fails on physical device due to camera access denial. What key is likely missing?",
      questionBG: "Функция работи в симулатор, но на реално устройство камерата е отказана. Кой ключ най-вероятно липсва?",
      answersEN: [
        "NSCameraUsageDescription",
        "CFBundleVersion",
        "UIStatusBarStyle",
        "NSHumanReadableCopyright"
      ],
      answersBG: [
        "NSCameraUsageDescription",
        "CFBundleVersion",
        "UIStatusBarStyle",
        "NSHumanReadableCopyright"
      ],
      correctEN: "NSCameraUsageDescription",
      correctBG: "NSCameraUsageDescription",
      explanationEN: "Privacy-protected APIs require usage description strings in Info.plist. Without them, access is denied.",
      explanationBG: "За защитени от privacy API-та са задължителни usage description ключове в Info.plist. Без тях достъпът се отказва."
    },
    intermediate: {
      questionEN: "App review rejects build for tracking transparency flow. What is the expected runtime behavior?",
      questionBG: "App Review отхвърля build заради tracking transparency. Кое поведение е очаквано по време на работа?",
      answersEN: [
        "Request tracking authorization contextually before tracking",
        "Track by default and ask later",
        "Show prompt on every launch until accepted",
        "Hide prompt behind debug flag"
      ],
      answersBG: [
        "Контекстна заявка за tracking разрешение преди проследяване",
        "Проследяване по подразбиране и питане после",
        "Prompt при всяко стартиране до приемане",
        "Скриване на prompt-а зад debug флаг"
      ],
      correctEN: "Request tracking authorization contextually before tracking",
      correctBG: "Контекстна заявка за tracking разрешение преди проследяване",
      explanationEN: "ATT requires informed, timely consent before tracking. Delayed or forced patterns violate policy.",
      explanationBG: "ATT изисква информирано и навременно съгласие преди проследяване. Закъснели или насилени шаблони нарушават политиката."
    },
    advanced: {
      questionEN: "Legal requires regional privacy behavior differences (EU vs non-EU) without binary forks. What design is best?",
      questionBG: "Правният екип изисква различно privacy поведение по региони (ЕС срещу извън ЕС) без разделяне на binary. Кой дизайн е най-добър?",
      answersEN: [
        "Policy-driven consent engine with remote-config rules",
        "Separate app per country",
        "Compile-time #if for each market",
        "Hardcode one strict mode globally"
      ],
      answersBG: [
        "Policy-driven consent engine с remote-config правила",
        "Отделно приложение за всяка държава",
        "Compile-time #if за всеки пазар",
        "Твърдо един строг режим глобално"
      ],
      correctEN: "Policy-driven consent engine with remote-config rules",
      correctBG: "Policy-driven consent engine с remote-config правила",
      explanationEN: "Policy engines allow auditable regional behavior changes without redeploying binaries for every legal update.",
      explanationBG: "Policy engine позволява проследими регионални промени без нов binary за всяка правна актуализация."
    }
  }
];
