# Приложение AskMe 
Привет! Это клон известного приложения AskFm, написанный на Ruby (v. 2.7.1) и Rails (v. 6.0.3.2)

Суть проста: регистрируетесь, задаёте вопросы другим пользователям, отвечаете сами на вопросы.
Всё как в старые добрые времена :)

Приложение написано в рамках учебного курса [Хороший Программист](goodprogrammer.ru)

## Установка и запуск на локальном сервере
```
git clone git@github.com:Giasod/askme.git
cd ./askme
bundle install
bundle exec rake db:migrate
bundle exec rails s
```
