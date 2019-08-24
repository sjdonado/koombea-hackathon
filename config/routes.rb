Rails.application.routes.draw do
  namespace :v1 do
    scope :users do
      post '/sign_up', to: 'users#sign_up'
      post '/sign_in', to: 'users#sign_in'
      post '/sign_out', to: 'users#sign_out'
    end

    scope :profile do
      get '/', to: 'profile#show'
      put '/', to: 'profile#update'
      put '/photo', to: 'profile#update'
    end
  end
end
