module Api
    module V1
        class CombosController < BaseController
            before_action :logged_in_user, only: [:create, :destroy]
            before_action :correct_user,   only: [:destroy]
            before_action :set_characters, only: [:index, :show]
            def create
                @combo = current_user.combos.new(combo_params)
                if @combo.save
                    render json: @combo, status: :created
                else
                    render json: @combo.errors, status: :unprocessable_entity
                end
            end

            def destroy
                @combo.destroy
                head :no_content
            end

            private

                def combo_params
                    params.require(:combo).permit(:title, :comando, :description, :damage, :hit_count, :character_id, :video_url, situation: [])
                end

                def correct_user
                    @combo = current_user.combos.find_by(id: params[:id])
                    render json: { error: "ログインしていません" }, status: :unauthorized if @combo.nil?
                end

                def set_characters
                    @characters = Character.all
                end

                def logged_in_user
                    unless logged_in?
                        render json: { error: "ログインしていません" }, status: :unauthorized
                    end
                end
        end
    end
end