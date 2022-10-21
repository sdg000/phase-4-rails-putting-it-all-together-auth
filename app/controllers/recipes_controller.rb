class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    before_action :require_login

    #action to allow a logged in user see all recipes and their individual users
    def index
        render json: Recipe.all, status: :created
    end

    #action to allow currently logged in user to create a recipe and save to db
    # LOGIC:
    # -since #create is pro#login action, a user has to definetely log in before being able to create Recipe Instance
    # -since userID of any logged user is saved to session[:user_id], we can save that to "current_user"
    # -since a user has_many recipes, we can create a recipe strictly for only current_user
    def create
        if session[:user_id]
            current_user = User.find_by(id: session[:user_id])
            recipe = current_user.recipes.create!(recipe_params)
            # render json: recipe, status: :created 

        end
        render json: recipe, status: :created 
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, :user_id)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
