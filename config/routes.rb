Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'music', action: :index, controller: 'music'
    end
  end
end
