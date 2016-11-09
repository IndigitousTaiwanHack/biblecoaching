class Api::PostsController < Api::ApplicationController

  #return bible: title, content
  #reutrn post: date, user_name, user_uid, id, response count, post like count
  def popular
    data = Hash.new
    begin
      post = Post.popular
      data = render_post(post)
      result = 0
    rescue
      result = -1
    end

    render :json => {result: result, post:data}
  end

  def show
      data = Hash.new
    begin
      post = Post.find(post_id)
      data = render_post(post)
      data[:is_like] = Rank.by_user(login_uid).first ? true : false
      result = 0
    rescue
      result = -1
    end

    render :json => {result: result, post:data}
  end

  def create
    begin
      user = User.find_by_uid(params[:uid]).first
      post = Post.new({user_id: user.id,bible_bid: params[:bible_bid], content: params[:content]})
      result = post.save ? 0 : -1
    rescue
      result = -1
    end
    render :json => {result: result}
  end

  def recommend_list
    posts=[]
    begin
      user = User.find_by_uid(params[:uid]).first
      users = user.get_focus_users
      unless users.empty?
        posts = get_focus_users_posts(users)
      end
      posts = posts + get_latest_list
      result = 0
    rescue
      result = -1
    end
    render :json => {result: result, posts: posts}
  end

  def latest_list
    posts=[]
    begin
      posts = get_latest_list
      result = 0
    rescue
      result = -1
    end

    render :json => {result: result, posts: posts}
  end

  def by_bible
    data =[]
    begin
      posts = Post.find_by_bible_bid(params[:bible_bid]).all
      posts.each do |post|
        data << render_post(post)
      end
      result = 0
    rescue
      result = -1
    end
    render :json => {result: result, posts: data}
  end

  private

  def get_focus_users_posts(users)
    posts=[]
    data =[]
    users.each do |user|
      posts << Post.find_by_user(user.id).order("updated_at desc").limit(5).all
    end
    posts.each do |post|
      data << render_post(post.first)
    end
    return data
  end

  def get_latest_list
    data =[]
    posts = Post.order("updated_at desc").all
    posts.each do |post|
      data << render_post(post)
    end
    return data
  end
end
