🎬 MovieApp — каталог фільмів та серіалів з трейлерами

MovieApp — iOS-додаток на Swift / UIKit для перегляду фільмів та серіалів, їх трейлерів та акторів, з можливістю пошуку та додавання до списку улюблених. Використовує TMDb API.

---

🔗 TMDb Disclaimer
- This product uses the TMDB API but is not endorsed or certified by TMDB.

---

🚀 Основні можливості

- Пошук за контентом
- Фільтрування за жанрами
- Популярні та трендові фільми та серіали
- Детальні сторінки фільмів, серіалів та акторів
- Трейлери через YouTubeiOSPlayerHelper
- Список улюблених
  
---

🧩 Архітектура

- MVP (Model-View-Presenter)
- Protocol-Oriented Programming
- Dependency Injection через ініціалізатори
- Розділ шарів: DTO → Domain → ViewModel

---

🌐 Робота з мережею

- TMDb API (фільми, серіали, актори, трейлери)
- Асинхронні запити через async/await
- репозиторії + мапінг моделей

---

💾 Робота з даними

- CoreData - вибране
- Keychain - Passcode
- Kingfisher — завантаження та кеш зображень
---

🧭 Навігація

- Навігація винесена в Routers, створення модулів через Builder

---

🎛 UI

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
