class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def show
    user = User.find_by(id: params[:id])
    render json: user, include: :items
  end
  def users_index
    users = User.all
    render json: users, include: :items
  end

  def item
    item = Item.find(params[:id])
    render json: item, include: :user
  end

  private

  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end
end
