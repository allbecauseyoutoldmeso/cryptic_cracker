Rails.application.routes.draw do
  namespace :api do
    resource :v1, controller: 'v1' do
      get :definitions
      get :synonyms
      get :anagrams
      get :matches
    end
  end
end
