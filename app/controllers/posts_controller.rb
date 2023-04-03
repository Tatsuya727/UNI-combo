class PostsController < ApplicationController
  def index
    @combo      = Combo.all
    @feed_items = Combo.all.page(params[:page])
  end
end
