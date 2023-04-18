class CombosController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user,   only: [:destroy]

    def index
        if params[:character_id].present?
            @combo     = Combo.where(character_id: params[:character_id]).page(params[:page])
            @character = Character.find(params[:character_id])
        else
            @combo = Combo.all.page(params[:page])
        end
        @characters = Character.all
    end

    def show
        @combo      = Combo.find(params[:id])
        @characters = Character.all
    end
    
    def new
        @combo = Combo.new
    end

    def create
        @combo = current_user.combo.new(combo_params)
        if @combo.save
            flash[:success] = "投稿完了"
            redirect_to root_url
        else
            @feed_items = current_user.feed.page(params[:page])
            render "new", status: :unprocessable_entity
        end
    end

    def destroy
        @combo.destroy
        flash[:success] = "削除しました"
        if request.referrer.nil?
            redirect_to root_url, status: :see_other
        else
            redirect_to request.referrer, status: :see_other
        end
    end

    def post_ajax
        render partial: "post-comando/character#{params[:character_id]}", locals: { combo: @combo }
    end

    private

        def combo_params
            params.require(:combo).permit(:title, :comando, :description, :damage, :hit_count, :character_id, :video_url, situation: [])
        end

        def correct_user
            @combo = current_user.combo.find_by(id: params[:id])
            redirect_to root_url, status: :see_other if @combo.nil?
        end
end
