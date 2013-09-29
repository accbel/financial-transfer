require 'spec_helper'

describe TransfersController do

  describe 'GET index' do
    let(:available_transfers) {
      [double('transfer')]
    }

    before {
      Transfer.should_receive(:all).and_return(available_transfers)
      get :index 
    }

    it 'should find all transfers' do
      assigns(:transfers).should == available_transfers
    end

    it { should render_template(:index) }
  end

  describe 'GET new' do
    before { get :new }

    it { should render_template(:new) }
    it { assigns(:transfer).should be_a_kind_of(Transfer) }
  end

  describe 'POST create' do
    let(:transfer) { 
      double("transfer").tap { |d| d.stub(:save) }
    }

    let(:params) {
      { transfer: {
        source_account: '12345-6',
        destination_account: '54321-0',
        amount: '780.50',
        due_date: (Date.today + 10.day).strftime('%yy-%m-%d')
      }}.with_indifferent_access
    }

    it 'should create a new transfer' do
      Transfer.should_receive(:new).with(params[:transfer]).and_return(transfer)
      post :create, params
      assigns(:transfer).should == transfer
    end

    context 'transfer was saved successfully' do
      before do
        Transfer.any_instance.should_receive(:save).and_return(true)
        post :create, params
      end

      it 'should redirect to index' do
        response.should redirect_to(transfers_path)
      end
    end

    context 'transfer was not saved' do
      before do
        Transfer.any_instance.should_receive(:save).and_return(false)
        post :create, params
      end

      it 'should render new template' do
        response.should render_template(:new)
      end
    end
  end

  describe 'DELETE destroy' do
    let(:transfer) { 
      double("transfer").tap { |d| d.stub(:destroy) }
    }
    let(:params) {
      {id: '123'}.with_indifferent_access
    }

    before do
      Transfer.stub(:find).with(params[:id]).and_return(transfer)
      transfer.stub(:destroy)

      delete :destroy, params
    end

    it 'should destroy the transfer' do
      expect(transfer).to have_received(:destroy)
    end

    it 'should redirect to index' do
      response.should redirect_to(transfers_path)
    end
  end
end