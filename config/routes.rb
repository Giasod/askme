Rails.application.routes.draw do
  # Это правило говорит: если пользователь заходит по адресу /, направь его в
  # контроллер users, действие index. Грубо говоря, на главной странице у нас
  # список юзеров.
  root 'users#index'
  
  # Эти две строчки добавляют ресурсы для пользователей и вопросов. Ресурс — это
  # набор путей для управления соответствующей моделью. Посмотрите, что напишет
  # команда
  #
  # rake routes
  resources :users
  resources :questions
  
  get 'users/index'
  get 'users/new'
  get 'users/edit'
  get 'users/show'
  get 'show' => 'users#show'
end
