class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user, :get_bible_contents

  def get_bible_contents(bible)
    contents = []
    bible.bible_contents.each do |content|
      contents << "#{content.content_id.to_s } #{content.content.to_s}"
    end
    return contents.join("\n").html_safe
  end

  def check_logged
    unless current_user
      redirect_to login_path
    end
  end
end
