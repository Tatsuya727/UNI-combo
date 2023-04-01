class CombosController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]

    def new
        @combo = Combo.new
    end
    def create
        @combo = current_user.combo.new(combo_params)
        if @combo.save
            flash[:success] = "投稿完了"
            redirect_to root_url
        else
            render "new", status: :unprocessable_entity
        end
    end

    def destroy

    end

    private

        def combo_params
            params.require(:combo).permit(:title, :comando, :description, :damage, :hit_count, :character_id, :video_url, situation: [])
        end
end
