class BaseFeeType
  def initialize transfer
    @transfer = transfer
  end

  def apply
    apply_type
    apply_fee
  end

  private
  def fee_type; end
  
  def fee_value; end

  def apply_type
    @transfer.fee_type = fee_type
  end

  def apply_fee
    @transfer.fee = fee_value
  end
end