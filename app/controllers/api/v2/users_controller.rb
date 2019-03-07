module Api
  module V2
    class UsersController < ActionController::API
      def save_user
        render json: { result: UserService.save(user_params) }, status: :created
      end

      private

      def user_params
        params.require(:user).permit(:id, :name, :email).to_h.deep_symbolize_keys
      end
    end
  end
end
