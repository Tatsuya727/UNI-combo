class PostsController < ApplicationController
  def index
    @combo      = Combo.all
    @feed_items = Combo.all.page(params[:page])
    @characters = Character.all
  end
end
