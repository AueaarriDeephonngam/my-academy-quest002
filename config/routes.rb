Rails.application.routes.draw do
  get "brag_documents/show"
  root "quests#index"

  resources :quests, only: [ :index, :create, :destroy ] do
    member do
      patch :toggle
    end
  end

  get "brag_document", to: "brag_documents#show"

  # Favicon route to prevent 404 errors in tests
  get "/favicon.ico", to: proc { [ 204, {}, [] ] }
end
