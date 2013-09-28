require 'spec_helper'

describe FeeTypeC do

  let(:sample) { build(:transfer,fee: 0,type: nil) }

  before { described_class.new(subject).apply }

  describe '#apply' do

    subject { sample }

    its(:type) { should == 'C' }

    context 'due date greather than 30 days from today' do
      subject { build(:transfer,amount: 140.0,due_date: (Date.today + 31.day)) }
      its(:fee) { should == 1.68 }
    end

    
    (26..30).each do |d|
      context "due date settled to #{d} day from today" do
        subject { build(:transfer,amount: 140.0,due_date: (Date.today + d.day)) }
        its(:fee) { should == 2.94 }
      end
    end
  end
end