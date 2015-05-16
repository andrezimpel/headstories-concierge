Rails.application.routes.draw do

  # users
  devise_for :users
  resources :users


  # clients
  get 'clients/thank-you/:id' => 'clients#thank_you', as: 'thank_you'
  resources :clients
  get '/clients/accept_invitation/:token' => 'clients#accept_invitation', as: 'accept_client_invitation'
  get 'clients/:id/resend_invitation' => 'clients#resend_invitation', as: 'resend_client_invitation'

  # appointments
  resources :appointments

  # root
  root to: redirect('/appointments')
end
