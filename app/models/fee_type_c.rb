class FeeTypeC < BaseFeeType
  private
  def fee_type
    'C'
  end

  def fee_value
    @transfer.amount * rate
  end

  def rate
    ({(0..5) => 8.3,(6..10) => 7.4,(11..15) => 6.7,(16..20) => 5.4,(21..25) => 4.3,(26..30) => 2.1}.select { |k,v|
      k.include? (@transfer.due_date - Date.today).to_i
    }.values.first || 1.2) / 100
  end
end