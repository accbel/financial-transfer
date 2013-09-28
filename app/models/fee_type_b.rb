class FeeTypeB < BaseFeeType
  
  private
  def fee_type
    'B'
  end
  
  def fee_value
    (@transfer.due_date - Date.today).to_i <= 30 ? 10.0 : 8.0
  end
end