Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts, only: [ :index, :show, :update, :create, :destroy ] do
        resources :comments, only: [ :create, :update, :destroy ] do
          resources :subcomments, only: [ :create, :update, :destroy ]
        end
      end
    end
  end

end
