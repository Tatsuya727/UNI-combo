class LikesController < ApplicationController
    def create
        puts 1
        @like= current_user.likes.create(combo_id: params[:combo_id])
        redirect_back(fallback_location: root_path)
    end

    def destroy
        @like = Like.find_by(combo_id: params[:combo_id], user_id: current_user.id)
        @like.destroy
        redirect_back(fallback_location: root_path)
    end

    private
    def like_params
        params.require(:like).permit(:combo_id)
    end
end
