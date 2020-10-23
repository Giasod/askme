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
yarn install --check-files
bundle exec rake db:migrate
bundle exec rails s
```

Чтобы работала `reCAPTCHA` вам  надо получить свои уникальные ключи. Затем пропишите их у себя
локально:
```
nano ~/.bash_profile
export RECAPTCHA_ASKME_PUBLIC_KEY="<тут публичный ключ>"
export RECAPTCHA_ASKME_PRIVATE_KEY="<тут приватный ключ>"
```

ВАЖНО! Если будете менять названия переменных, не забудьте поменять их в файле `config/initializers/recaptcha.rb`

Если у вас тоже RubyMine, пропишите их в переменных окружения.
`Edit Configurations -> Environment variables`

В этом окне добавьте переменные и сохраните.

Вуаля, вы восхитительны!
