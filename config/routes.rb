Rails.application.routes.draw do
  namespace :v1, defaults: {format: :json} do
    scope :users do
      post '/sign_up', to: 'users#sign_up'
      post '/sign_in', to: 'users#sign_in'
      post '/sign_out', to: 'users#sign_out'
    end

    scope :profile do
      get '/', to: 'profile#show'
      put '/', to: 'profile#update'
      put '/photo', to: 'profile#update_photo'
    end
  end
end
