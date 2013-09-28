require 'spec_helper'

describe FeeTypeB do

  let(:sample) { build(:transfer,fee: 0,type: nil) }

  describe '#apply' do

    before { described_class.new(sample).apply }

    it { sample.type.should == 'B' }

    context 'due date less or equal to 30 days' do
      let(:sample) { build(:transfer,due_date: Date.today + 30.day)}

      it { sample.fee.should == 10.0 }
    end

    context 'due date greater than 30 days' do
      let(:sample) { build(:transfer,due_date: Date.today + 31.day)}

      it { sample.fee.should == 8.0 }
    end
  end
end