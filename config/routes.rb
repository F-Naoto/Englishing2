Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :teachers, controllers: {
    sessions:      'teachers/sessions',
    passwords:     'teachers/passwords',
    registrations: 'teachers/registrations'
  }
  devise_for :students, controllers: {
    sessions:      'students/sessions',
    passwords:     'students/passwords',
    registrations: 'students/registrations'
  }
  get 'best_answers/create'
  get 'teacher_reviews/ranking', to: 'teacher_reviews#ranking'
  root to: 'home#top'
  resources :students do
    member do
      get :st_following
    end
    member do
      get :ss_following
    end
    member do
      get :ss_follower
    end
    collection do
      get 'search'
    end
  end
  resources :teachers do
    collection do
      get 'search'
    end
    resources :teacher_reviews, only:%i[index create]
  end
  resources :questions do
    resource :likes, only:%i[create destroy]
  end
  resources :answers
  resources :st_relationships, only:%i[create destroy]
  resources :ss_relationships, only:%i[create destroy]
  resources :ss_notifications, only:%i[index]
  resources :best_answers,     only:%i[create]
  resources :chat_rooms,       only:%i[create show]
end
