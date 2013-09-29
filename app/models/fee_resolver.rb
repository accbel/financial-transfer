class FeeResolver

  STRATEGIES = {
    Proc.new { |value| value >= 0.0 && value < 25001.0 } => FeeTypeA,
    Proc.new { |value| value >= 25001.0 && value < 120001.0 } => FeeTypeB,
    Proc.new { |value| value >= 120001.0 } => FeeTypeC,
  }

  def self.apply transfer
    STRATEGIES.select { |k,v| k.call(transfer.amount) }.values.first.new(transfer).apply
  end
end