require 'spec_helper'

describe FeeTypeA do

  let(:sample) { build(:transfer,amount: 280.00,fee: 0,type: nil) }

  describe '#apply' do
    
    before { described_class.new(sample).apply }

    it { sample.type.should == 'A' }
    it { sample.fee.should == 10.4 }
  end
end