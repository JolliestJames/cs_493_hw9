module Api
  module V1
    class MusicController < ActionController::API
      def index
        render json: { music: MusicService.music }, status: :ok
      end
    end
  end
end
