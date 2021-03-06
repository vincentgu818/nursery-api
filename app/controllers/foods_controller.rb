class FoodsController < ApplicationController

  def index
    render json: Food.all
  end

  def show
    render json: Food.find(params["id"])
  end

  def create
    render json: Food.create(params)
  end

  def delete
    render json: Food.delete(params["id"])
  end

  def update
    render json: Food.update(params["id"], params)
  end

end
