class UsersController < ApplicationController
  before_action :check_logged, :only=>[:show, :post_list]

  def show
  end

  def post_list
    @posts = Post.find_by_user(@current_user.id).all
    respond_to do |format|
      format.js
    end
  end

end
