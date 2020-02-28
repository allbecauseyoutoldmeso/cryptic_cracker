Rails.application.routes.draw do
  resource :api, controller: 'api' do
    get :definitions
    get :synonyms
    get :anagrams
    get :matches
  end
end
