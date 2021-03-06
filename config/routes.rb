Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'questions#index'

  resources :questions do
    resources :answers, shallow: true, except: %i[index show]
  end
end
