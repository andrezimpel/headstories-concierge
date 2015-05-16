Rails.application.routes.draw do

  devise_for :users


  # clients
  get 'clients/thank-you/:id' => 'clients#thank_you', as: 'thank_you'
  resources :clients
  get '/clients/accept_invitation/:token' => 'clients#accept_invitation', as: 'accept_invitation'

  # appointments
  resources :appointments

  # root
  root to: redirect('/appointments')
end
