class FeeTypeA < BaseFeeType
 
  private
  def fee_type
    'A'
  end
  
  def fee_value
    (@transfer.amount * 0.03) + 2.0
  end
end