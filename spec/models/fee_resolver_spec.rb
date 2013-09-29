require 'spec_helper'

describe FeeResolver do

  before { described_class.apply(subject) }

  context 'when transfer value is between 0 and 25000' do

    subject { build(:transfer,amount:rand(0..25000),fee_type:nil) }

    its(:fee_type) { should == 'A' }
  end

  context 'when transfer value is between 25001 and 120000' do
    subject { build(:transfer,amount:rand(25001..120000),fee_type:nil) }

    its(:fee_type) { should == 'B' }
  end

  context 'when transfer value is above 120000' do
    subject { build(:transfer,amount:rand(25001..999999),fee_type:nil) }

    its(:fee_type) { should == 'C' }
  end
end