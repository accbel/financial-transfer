require 'spec_helper'

describe FeeTypeC do

  let(:sample) { build(:transfer,fee: 0,fee_type: nil) }
  let(:amount) { 140.0 }

  before { described_class.new(subject).apply }

  def transfer_at due_day
    build(:transfer,amount: amount,due_date: (Date.today + due_day.day))
  end

  def expected_fee rate
    BigDecimal((amount * (rate/100)),8).round(2)
  end

  describe '#apply' do

    subject { sample }

    its(:fee_type) { should == 'C' }

    context 'due date greather than 30 days from today' do
      subject { transfer_at 31 }
      its(:fee) { should == 1.68 }
    end

    {(0..5) => 8.3,
     (6..10) => 7.4,
     (11..15) => 6.7,
     (16..20) => 5.4,
     (21..25) => 4.3,
     (26..30) => 2.1}.each do |range,rate|
      range.each do |d|
        context "due date settled to #{d} day from today" do
          subject { transfer_at d }
          it "should apply a #{rate}% fee" do
            subject.fee.round(2).should == expected_fee(rate)
            # puts "Calculado: #{expected_fee(rate)}"
            # puts "Obtido: #{subject.fee}"
          end
        end
      end
    end
  end
end