module PostsHelper

  def render_rank_count(post)
    return Rank.by_type_and_id("post",post.id).count
  end

  def render_response_count(post)
    return post.responses.count
  end

  def render_user_photo(user_id)
    return User.find(user_id).url
  end
end
