Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  get 'best_answers/create'
  root to: 'home#top'
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
  resources :students do
    member do
      get :following
    end
    collection do
      get 'search'
    end
  end
  resources :teachers do
    member do
      get :followers
    end
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
  resources :best_answers, only:%i[create]
  resources :chat_rooms, only:%i[create show]
end
