class Transfer < ActiveRecord::Base
  before_create do |transfer|
    FeeResolver.apply(transfer)
  end

  validates :source_account, presence: true, format: { with: /\A[0-9]{5}\-[0-9]{1}\z/ }
  validates :destination_account, presence: true, format: { with: /\A[0-9]{5}\-[0-9]{1}\z/ }
  validates :amount, numericality: { greater_than: 0.0 }
  validates :due_date, :date => {after_or_equal_to: Proc.new { Date.today } }
  validate :check_different_accounts

  def check_different_accounts
    errors.add(:source_account, :distinct) if source_account == destination_account
  end
end