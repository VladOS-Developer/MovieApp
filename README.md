---

🎬 MovieApp — iOS-додаток на Swift / UIKit для перегляду фільмів та серіалів, їх трейлерів та акторів, з можливістю пошуку та додавання до списку улюблених. Використовує TMDb API.

---

🔗 TMDb Disclaimer
- This product uses the TMDB API but is not endorsed or certified by TMDB.

---

🔍 Основні можливості

- Пошук фільмів/серіалів, зроби вибір улюбленого жанру
- Перегляд популярних та трендових релізів
- Детальні сторінки з інформацією про фільм/серіал і акторів
- Перегляд трейлерів через YouTube
- Додавання у список улюблених
- Ділитися з друзями (Telegram, Twitter, Share)
- Passcode‑екран для захисту
  
---

🏛 Архітектура

- MVP архітектура з пошаровим поділом Data / Domain / Presentation, пасивним UI, навігацією через Routers та Builder як composition root.
- Presenter містить всю бізнес‑логіку(у майбутньому UseCase).
- ViewController відповідає лише за UI lifecycle та відображення.

- Layered separation (Data / Domain / Presentation)
- Router‑based navigation — навігація відокремлена від UI.
- Builder як Composition Root — централізована збірка модулів та DI.

🧩 Шари
- Data Layer - NetworkService - універсальний HTTP-клієнт, що відповідає за формування запитів. 
             - Repository - інкапсулює джерела даних і виконує мапінг DTO → Domain.
  
- Domain Layer — бізнес‑логіка, моделі, незалежні від UI та мережі.
  
- Presentation Layer — ViewControllers + Presenters + ViewModels, пасивний UI.
  
---

🌐 Мережеві дані

- TMDb API
- Асинхронні запити з використанням async / await
- Типобезпечні Endpoint-и

---

💾 Робота з даними

- CoreData — збереження вибраного
- Keychain — Passcode (у майбутньому Auth)
- Kingfisher — завантаження та кешування зображень
  
---

📱 UI побудований на UIKit

- Layout секцій генерується через LayoutFactory.
- Cells конфігуруються через ViewModels.
  
- UICollectionView (CompositionalLayout & FlowLayout)
- UITableView
- UITabBarController
- UIStackView
- NSLayoutConstraint

---

📱 Скріншоти

### 🏠 Main Screen
<p align="center">
  <img src="Screenshots/main_screen.png" width="250"/>
  <img src="Screenshots/main_screen_search.png" width="250"/>
</p>

### 🎬 Movie Page
<p align="center">
  <img src="Screenshots/movie_page1.png" width="250"/>
  <img src="Screenshots/movie_page2.png" width="250"/>
  <img src="Screenshots/movie_page3.png" width="250"/>
</p>

### 📺 TV Series Page
<p align="center">
  <img src="Screenshots/series_page1.png" width="250"/>
  <img src="Screenshots/series_page2.png" width="250"/>
  <img src="Screenshots/series_page3.png" width="250"/>
</p>

### 👤 Actor Page
<p align="center">
  <img src="Screenshots/actor_filmography.png" width="250"/>
  <img src="Screenshots/actor_biography.png" width="250"/>
</p>

### 📦 Passcode / Settings / DynamicList / Player
<p align="center">
  <img src="Screenshots/passcode_page.png" width="250"/>
  <img src="Screenshots/setting_page.png" width="250"/>
  <img src="Screenshots/dynamic_list_page.png" width="250"/>
  <img src="Screenshots/trailer_player.png" width="250"/>
</p>
