Rails.application.routes.draw do
  get 'genres', action: :genres, controller: 'api/v2/music'
  get 'artists', action: :artists, controller: 'api/v2/music'
  get 'albums', action: :albums, controller: 'api/v2/music'
  get 'songs', action: :songs, controller: 'api/v2/music'
  get 'song', action: :song, controller: 'api/v2/music'

  namespace :api do
    namespace :v1 do
      get 'music', action: :index, controller: 'music'
    end
  end
end
