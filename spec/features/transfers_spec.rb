require 'spec_helper'

describe "Transfers" do
  let(:transfer) {
    build :transfer
  }

  context '/transfers' do
    before do
      transfer.save
    end
    it "should view all transfers available" do
      visit '/transfers'

      expect(page).to have_content transfer.fee_type
      expect(page).to have_content transfer.source_account
      expect(page).to have_content transfer.destination_account
      expect(page).to have_content ActionController::Base.helpers.number_to_currency(transfer.amount)
      expect(page).to have_content ActionController::Base.helpers.number_to_currency(transfer.fee)
      expect(page).to have_content I18n.l(transfer.due_date)
    end

    it 'should destroy a transfer' do
      visit '/transfers'

      click_link 'Excluir'

      expect(page).to_not have_content transfer.source_account
      expect(page).to_not have_content transfer.destination_account
      expect(page).to_not have_content ActionController::Base.helpers.number_to_currency(transfer.amount)
      expect(page).to_not have_content ActionController::Base.helpers.number_to_currency(transfer.fee)
      expect(page).to_not have_content I18n.l(transfer.due_date)
    end
  end

  it "should save a new transfer" do
    visit '/transfers'
    click_link 'Nova transferência'

    current_path.should == new_transfer_path

    fill_in('Conta de origem', :with => '12345-6')
    fill_in('Conta de destino', :with => '54321-0')
    fill_in('Data de efetivação', :with => Date.today.strftime('%Y-%m-%d'))
    fill_in('Valor', :with => '150.0')

    click_button('Criar Transferência')

    current_path.should == transfers_path

    expect(page).to have_content '12345-6'
    expect(page).to have_content '54321-0'
    expect(page).to have_content ActionController::Base.helpers.number_to_currency(150.0)
    expect(page).to have_content ActionController::Base.helpers.number_to_currency(6.5)
    expect(page).to have_content I18n.l(Date.today)
  end
end