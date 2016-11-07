class PostsController < ApplicationController

  before_action :check_logged

  def index
    @posts = Post.order("updated_at desc").all
  end

  def new
    @bible = Bible.find_by_bid(params[:bid])
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    if @post.save
      redirect_to post_index_path
    end
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:bible_bid, :content)
  end

end
