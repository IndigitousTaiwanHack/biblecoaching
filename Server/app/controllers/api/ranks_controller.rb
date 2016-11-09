class Api::RanksController < Api::ApplicationController

  def create
    begin
      user = User.find_by_uid(rank_param[:uid]).first
      if rank_param[:post_id]
        query = {user_id: user.id, rank_type: "post", object_id: rank_param[:post_id]}
      else
        query ={user_id:  user.id, rank_type: "response", object_id: rank_param[:response_id]}
      end
      rank = Rank.new(query)
      if rank.valid?
        result = rank.save ? 0:-1
      else
        result = 3
      end
    rescue
      result = -1
    end

    render :json => {result: result}
  end

  private
  def rank_param
    params.permit(:uid, :post_id, :response_id)
  end
end
