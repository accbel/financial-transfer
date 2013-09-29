require 'spec_helper'

describe TransfersController do

  describe 'GET index' do
    before { get :index }

    it { should render_template(:index) }
  end

  describe 'GET new' do
    before { get :new }

    it { should render_template(:new) }
    it { assigns(:transfer).should be_a_kind_of(Transfer) }
  end

  describe 'POST create' do
    let(:params) {
      { transfer: {
        source_account: '12345-6',
        destination_account: '54321-0',
        amount: '780.50',
        due_date: Date.today + 10.day
      }}.with_indifferent_access
    }

    it 'should create a new transfer' do
      Transfer.should_receive(:new).with(params[:transfer])
      post :create, params
      assigns(:transfer).should be_a_kind_of(Transfer)
    end

    context 'transfer was saved successfully' do

    end
  end
end