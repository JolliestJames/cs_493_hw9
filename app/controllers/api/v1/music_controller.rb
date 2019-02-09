module Api
  module V1
    class MusicController < ActionController::API
      def index
        render json: { music: MusicService.encode_songs }, status: :ok
      end
    end
  end
end
