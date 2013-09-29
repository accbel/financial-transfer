class TransfersController < ApplicationController
  def index
    @transfers = Transfer.all
  end

  def new
    @transfer = Transfer.new
  end

  def create
    @transfer = Transfer.new(transfer_params)
    if @transfer.save
      redirect_to transfers_path
    else
      render :new
    end
  end

  def destroy
    Transfer.find(params[:id]).destroy
    redirect_to transfers_path
  end

  private
  def transfer_params
    params.require(:transfer).permit(:source_account, :destination_account, :due_date, :amount)
  end
end
