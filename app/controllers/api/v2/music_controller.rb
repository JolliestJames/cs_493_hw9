module Api
  module V2
    class MusicController < ActionController::API
      def genres
        render json: { genres: MusicService::V2.genres }, status: :ok
      end
    
      def artists
        render json: { artists: MusicService::V2.genre(params[:genre]) }, status: :ok
      end
    
      def albums
        render json: { albums: MusicService::V2.artist(params[:artist]) }, status: :ok
      end

      def songs
        render json: { songs: MusicService::V2.album(params[:album]) }, status: :ok
      end

      def song
        render json: { url: MusicService::V2.song(params[:song]) }, status: :ok
      end

      def play
        render json: { result: MusicService::V2.play(play_params) }, status: :accepted
      end

      private

      def play_params
        params.require(:music).permit(:artist, :album, :song)
      end
    end
  end
end
