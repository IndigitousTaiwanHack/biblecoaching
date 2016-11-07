class Api::UsersController < Api::ApplicationController

  # return success or fail
  def register
    begin
      result = User.from_api(user_params)
    rescue
      result = -1
    end
    render :json => {:result=>result}
  end

  # return name, post count, post like count, response like count
  def show
    user = User.find_by_uid(params[:uid]).first
    begin
      data = Hash.new
      data[:name] = user.name
      data[:post_count] = user.posts.count
      data[:post_rank_count] =  get_post_rank_count(user.id)
      data[:response_rank_count] = get_response_rank_count(user.id)
      result = 0
    rescue
      result = -1
    end
    render :json => {:result=>result, :user=>data}
  end

  def like
    begin
      result = User.from_api(user_params)
    rescue
      result = -1
    end
    render :json => {:result=>result}
  end

  def unlike
    begin
      result = User.from_api(user_params)
    rescue
      result = -1
    end
    render :json => {:result=>result}
  end

  def post_list
    data=[]
    begin
      user = User.find_by_uid(user_params[:uid]).first
      posts = Post.find_by_user(user.id).all
      posts.each do |post|
        data << render_post(post)
      end
      result = 0
    rescue
      result = -1
    end
    render :json => {:result=>result, posts:data}
  end

  private
  def user_params
    params.permit(:uid, :provider, :name, :url, :user_id)
  end
end
