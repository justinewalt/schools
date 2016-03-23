Rails.application.routes.draw do
  # Root Route
  root 'schools#index'

  # Resource Routes
  resources :schools
end
