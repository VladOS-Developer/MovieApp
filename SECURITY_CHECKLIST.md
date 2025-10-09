# 🔐 Security Checklist

### Этот документ фиксирует правила работы с секретами (TMDB API key) для этого репозитория.

### Назначение
Файл описывает, как хранится и защищается API-ключ, какие проверки делать перед пушем и что делать при утечке.

# 🧱 Структура и правила

1. **Ключ TMDB API** хранится в локальном файле `Secrets.xcconfig` в корне проекта.  
2. **Никогда** не коммитьте и не загружайте `Secrets.xcconfig` в GitHub.  
3. API-ключи **не должны** присутствовать напрямую в Swift-коде.  
4. Для релизных сборок (App Store) рекомендуется использовать **Keychain** или **защищённый серверный прокси**.  
5. Перед каждым коммитом проверяйте `.gitignore`.

# ⚙️ Инструкция по настройке
## 1. Создание локального файла секретов
Создайте файл:
```bash```
touch MovieApp/Resources/Secrets.xcconfig

Добавьте в него свой ключ:
TMDB_API_KEY = your_tmdb_key_here

Файл **обязательно** должен быть добавлен в `.gitignore`.
`# Secrets`
`Secrets.xcconfig`


##2. Подключение Secrets.xcconfig к проекту
В Xcode: Откройте Project → Info → Configurations. (`TARGET LEVEL`)

Добавьте `Secrets.xcconfig` для конфигураций Debug и Release.

В Info.plist пропишите:

<key>TMDB_API_KEY</key>
<string>$(TMDB_API_KEY)</string>

##3. Проверка перед коммитом
Перед пушем выполните команды:
```bash```
git status
git check-ignore -v Secrets.xcconfig
git grep -n "TMDB_API_KEY" || true
git grep -n "your_real_api_key_here" || true

**Если в выводе виден ваш ключ** — остановитесь и **удалите** его перед коммитом.

## ✅ Пример успешной проверки
```bash```
git check-ignore -v Secrets.xcconfig

.gitignore:12:Secrets.xcconfig <- Результат проверки

Это означает, что файл **успешно игнорируется Git**.

## 🧩 Примечания
* В клиентском приложении допускается использование только read-only TMDB API-ключей.

* Никогда не добавляйте секреты продакшн-сервера или write-access токены.

* Все чувствительные конфигурационные файлы остаются только локально.

# © MovieApp — Проверено. Безопасность подтверждена. 👍
