Rails.application.routes.draw do

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :foods
      get '/data_version', to: 'status#data_version', as: :data_version
    end
    namespace :v2 do
      resources :foods
    end
  end

  root 'static_pages#home'

  get "/static_pages/*static_page" => "static_pages#show"
  get "/sakurafish/*sakurafish" => "sakurafish#show"

  match 'foods/index', to: 'foods#index', via: ['post', 'get']
  match 'foods/search', to: 'foods#search', via: ['post', 'get']
  match 'foods/search_t', to: 'foods#index_by_type_and_kind', via: ['post', 'get']

  resources :foods do
    get 'page/:page', :action => :index, :on => :collection
  end

  get '*not_found', controller: 'application', action: 'render_404'
  post '*not_found', controller: 'application', action: 'render_404'
end
