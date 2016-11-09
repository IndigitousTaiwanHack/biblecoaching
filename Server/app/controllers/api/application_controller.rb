class Api::ApplicationController < ApplicationController

  before_action :restrict_access
  skip_before_action :verify_authenticity_token

  private
  def restrict_access
    api_key = request.headers['hackathon-Api-Key']
    @key = ApiToken.where(access_token: api_key).first if api_key

    unless @key
      head status: :unauthorized
      return false
    end
  end

  def get_post_rank_count(user_id)
    posts = Post.find_by_user(user_id).all
    count = 0
    posts.each do |post|
      count += Rank.by_type_and_id("post",post.id).count
    end
    return count
  end

  def get_response_rank_count(user_id)
    responses = Response.find_by_user(user_id).all
    count = 0
    responses.each do |response|
      count +=Rank.by_type_and_id("response",response.id).count
    end
    return count
  end

  def get_bible_contents(bible)
    contents = []
    bible.bible_contents.each do |content|
      contents << "#{content.content_id.to_s } #{content.content.to_s}"
    end
    return contents.join("\n")
  end

  def render_post(post)
    data = Hash.new
    data[:bid] = post.bible_bid
    data[:bible_title] = post.bible.book.title
    data[:bible_content] = get_bible_contents(post.bible)
    data[:id] = post.id
    data[:date] = post.updated_at.strftime('%Y-%m-%d')
    data[:content] = post.content
    user = User.find(post.user_id)
    data[:uid] = user.uid
    data[:user_name] = user.name
    data[:user_url] = user.url
    data[:rank_count] = Rank.by_type_and_id("post",post.id).count
    data[:response_count] = post.responses.count
    return data
  end
end
