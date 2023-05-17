module Api
    module V1
    class BaseController < ActionController::API
        private

        def current_user
            token = request.headers["Authorization"]
            return nil if token.nil?
            user_id = User.decode(token)
            @current_user ||= User.find_by(id: user_id)
        end
    end
    end
end