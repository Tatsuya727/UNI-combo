class LikesController < ApplicationController
    def create
        @like= current_user.likes.create(like_params)
        redirect_to combos_path
    end

    def destroy
        @like = Like.find_by(combo_id: params[:combo_id], user_id: current_user.id)
        @like.destroy
        redirect_to combos_path
    end

    private
    def like_params
        params.require(:like).permit(:combo_id)
    end
end
