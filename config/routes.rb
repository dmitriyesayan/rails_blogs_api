Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts, only: [ :index, :show, :update, :create, :destroy ] do
        resources :comments, only: [ :index, :show, :create, :update, :destroy ] do
          resources :subcomments, only: [ :index, :show, :create, :update, :destroy ]
        end
      end
    end
  end

end
