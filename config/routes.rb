Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'documents#new'
  post '/mifiel/docs/callback', to: 'mifiel_callbacks#create'
  resources :documents,shallow:true do
    resources :signs
  end
end
