module Api
  module V1
    class MusicController < ActionController::API
      def index
        render json: { music: "Someday there will be music here" }, status: :ok
      end
    end
  end
end
