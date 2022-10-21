class UsersController < ApplicationController
    # handling invalid records
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    # overiding_require_login since a new user cannot be initially logged in when they are about to create account
    skip_before_action :require_login, only: :create


      #action to allow users to signup
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    #auto login
    #users who are not logged in will hit the require_login block
    def show
        user = User.find_by(id: session[:user_id])
        render json: user, status: :created

    end


    private 
    def user_params
        params.permit(:username, :password, :image_url, :bio, :password_confirmation)
    end

    # def require_login
    #     return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    # end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
    


end
