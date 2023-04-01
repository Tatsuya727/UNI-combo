class PostsController < ApplicationController
  def home
  end

  def index
    @combo = current_user.combo.build if logged_in?
  end
end
