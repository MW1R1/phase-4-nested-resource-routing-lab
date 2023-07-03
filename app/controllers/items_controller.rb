class ItemsController < ApplicationController
  before_action :set_user, only: [:index, :create]
  before_action :set_item, only: [:show]

  def index
    items = Item.all
    if user
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    render json: item, include: :user
  end

  def create
    item = user.items.build(item_params)
    if item.save
      render json: item, status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def all_items
    items = Item.all_items
    render json: items, include: :user
  end

  private

  def set_user
    user = User.find_by(id: params[:user_id])
    render json: { error: 'User not found' }, status: :not_found unless user
  end

  def set_item
    item = Item.find_by(id: params[:id])
    render json: { error: 'Item not found' }, status: :not_found unless item
  end

  def item_params
    params.permit(:name, :description, :price)
  end
end