class ApplicationController < ActionController::API
  include ActionController::Cookies

  #by placing login restriction, all controllers inherit login_retriction
  before_action :require_login


  private

  def require_login
    return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
end


end
