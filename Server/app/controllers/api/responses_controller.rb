class Api::ResponsesController < Api::ApplicationController

  def create
    begin
      user = User.find_by_uid(params[:uid]).first
      response = Response.new({post_id:params[:post_id], user_id: user.id, content: params[:content]})
      result = response.save ? 0 : -1
    rescue
      result = -1
    end
    render :json => {result: result}
  end

  def index
    begin
      post = Post.find(params[:post_id])
      responses = post.responses.order("updated_at desc")
      data = []
      responses.each do |response|
        user = response.user
        data << {user_name: user.name,
                 user_id: user.id,
                 user_url: user.url,
                 id: response.id,
                 content: response.content,
                 date: response.updated_at.strftime('%Y-%m-%d'),
                 response_rank: get_response_rank_count(user.id)}
      end
      result = 0
    rescue
      result = -1
    end
    render :json => {result: result, responses: data}
  end
end
