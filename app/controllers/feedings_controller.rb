class FeedingsController < ApplicationController

  def index
    render json: Feeding.all
  end

  def index_by_side
    render json: Feeding.all_by_side(params["side"])
  end

  def index_of_last_n_hours
    render json: Feeding.all_of_last_n_hours(params["n"])
  end

  def index_between_times
    render json: Feeding.all_between_times(params["start"],params["finish"])
  end

  def show
    render json: Feeding.find(params["id"])
  end

  def create
    render json: Feeding.create(params["feeding"])
  end

  def delete
    render json: Feeding.delete(params["id"])
  end

  def update
    render json: Feeding.update(params["id"], params["feeding"])
  end

end
