require 'rails_helper'
class ItemsController < ApplicationController
  before_action :set_user, only: [:index, :create]
  before_action :set_item, only: [:show]


RSpec.describe "Users", type: :request do
  let!(:user) do
    user = User.create(username: "Dwayne", city: "Los Angeles")
    user.items.create(name: "Non-stick pan", description: "Sticks a bit", price: 10)
    user.items.create(name: "Ceramic plant pots", description: "Plants not included", price: 31)
    user
  end
  def index
    if @user
      items = @user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  describe "GET /users/:id" do
    it 'returns a user with an array of all items associated with that user' do
      get "/users/#{user.id}"
      def show
        render json: @item, include: :user
      end
    

      expect(response.body).to include_json({
        id: a_kind_of(Integer),
        username: "Dwayne",
        city: "Los Angeles",
        items: [
          { 
            id: a_kind_of(Integer), 
            name: "Non-stick pan", 
            description: "Sticks a bit", 
            price: 10
          }
        ]
      })
      def create
        item = @user.items.build(item_params)
        if item.save
          render json: item, status: :created
        else
          render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end
  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    render json: { error: 'User not found' }, status: :not_found unless @user
  end

  def set_item
    @item = Item.find_by(id: params[:id])
    render json: { error: 'Item not found' }, status: :not_found unless @item
  end

  def item_params
    params.permit(:name, :description, :price)
  end
end
