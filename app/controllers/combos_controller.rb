class CombosController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :new]
    before_action :correct_user,   only: [:destroy]
    before_action :set_characters, only: [:index, :show]

    def index
        @combo = Combo.all
        @combo = @combo.where(character_id: params[:character_id]) if params[:character_id].present? # viewでキャラクターが選択された場合
        @combo = @combo.includes(:character, :situations)          if params[:situation].present? # シチュエーションが存在する場合
        @combo = @combo.page(params[:page]) # ページネーション
        @character  = Character.find(params[:character_id])        if params[:character_id].present? # viewでキャラクターが選択された場合
        @situations = Situation.all
    end

    def show
        @combo = Combo.find(params[:id])
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
            render "new", status: :unprocessable_entity
        end
    end

    def destroy
        @combo.destroy
        flash[:success] = "削除しました"
        redirect_to root_url, status: :see_other
    end

    def post_ajax
        render partial: "post-comando/character#{params[:character_id]}", locals: { combo: @combo }
    end

    def filter_ajax
        render partial: "filter-comando/character#{params[:character_id]}", locals: { combo: @combo }
    end

    private

        def combo_params
            params.require(:combo).permit(:title, :comando, :description, :damage, :hit_count, :character_id, :video_url, situation: [])
        end

        def correct_user
            @combo = current_user.combo.find_by(id: params[:id])
            redirect_to root_url, status: :see_other if @combo.nil?
        end

        def set_characters
            @characters = Character.all
        end
end
