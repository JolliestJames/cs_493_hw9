Rails.application.routes.draw do
  get 'genres', action: :genres, controller: 'api/v2/music'
  get 'artists/for/genre', action: :artists, controller: 'api/v2/music'
  get 'albums/for/artist', action: :albums, controller: 'api/v2/music'
  get 'songs/for/album', action: :songs, controller: 'api/v2/music'
  get 'song', action: :song, controller: 'api/v2/music'

  namespace :api do
    namespace :v1 do
      get 'music', action: :index, controller: 'music'
    end
  end
end
