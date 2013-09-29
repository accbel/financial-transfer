class TransfersController < ApplicationController
  def index
  end

  def new
    @transfer = Transfer.new
  end

  def create
    transfer = Transfer.new(params[:transfer])
    render :nothing => true
  end
end
