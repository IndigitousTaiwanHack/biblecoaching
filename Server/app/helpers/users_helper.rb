module UsersHelper

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
end
