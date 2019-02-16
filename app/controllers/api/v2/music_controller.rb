module Api
  module V2
    class MusicController < ActionController::API
      def genres
        render json: { hello: 'there'}
      end
    
      def artists
        render json: { hello: 'there'}
      end
    
      def albums
        render json: { hello: 'there'}
      end
    
      def songs
        render json: { hello: 'there'}
      end
    
      def song
        render json: { hello: 'there'}
      end
    end
  end
end
