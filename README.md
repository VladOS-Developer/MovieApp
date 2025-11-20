🎬 MovieApp — каталог фильмов и сериалов с трейлерами

MovieApp — iOS-приложение на Swift / UIKit для просмотра фильмов и сериалов, их трейлеров и актёров, с возможностью поиска и добавления в избранное. Использует TMDb API.

---

🔗 TMDb Disclaimer
- This product uses the TMDB API but is not endorsed or certified by TMDB.

---

🚀 Основные возможности

- Популярные и трендовые фильмы и сериалы
- Детальные страницы фильмов, сериалов и актёров
- Поиск по контенту
- Трейлеры через YouTubeiOSPlayerHelper
- Фильтрация по жанрам
- Избранное
- Passcode экран с безопасным хранением через Keychain

---

🧩 Архитектура

- MVP (Model–View–Presenter)
- Protocol-Oriented Programming
- Dependency Injection через инициализаторы
- Разделение слоёв: DTO → Domain → ViewModel

---

🌐 Работа с сетью

- TMDb API (фильмы, сериалы, актёры, трейлеры)
- Асинхронные запросы через async/await
- Репозитории + маппинг моделей

---

💾 Работа с данными

- CoreData — избранное
- Keychain — Passcode
- Kingfisher — загрузка и кэш изображений

---

🧭 Навигация

- Навигация вынесена в Routers, создание модулей через Builder

---

🎛 UI

- UICollectionView (CompositionalLayout & FlowLayout)
- UITableView
- UITabBarController
- UIStackView
- NSLayoutConstraint

---

📱 Скриншоты

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
