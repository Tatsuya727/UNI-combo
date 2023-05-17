class PostsController < ApplicationController
  def index
    if params[:character_id]
      @combo = Combo.where(character_id: params[:character_id]).page(params[:page])
    else
      @combo = Combo.all
    end
    @feed_items = Combo.all.page(params[:page])
    @characters = Character.all
  end
  
  def show
    @combo      = Combo.find(params[:id])
    @characters = Character.all
  end
end
