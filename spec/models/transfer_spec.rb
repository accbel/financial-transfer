require 'spec_helper'

describe Transfer do
  subject { build :transfer }

  it 'should have a valid source account' do
    subject.source_account = ''
    subject.should_not be_valid

    %w(123-1 111111 9876-1 87261-A 76B77-9).each do |account|
      subject.source_account = account
      subject.should_not be_valid
    end

    subject.source_account = '87637-5'
    subject.should be_valid
  end

  it 'should have a valid destination account' do
    subject.destination_account = ''
    subject.should_not be_valid

    %w(123-1 111111 9876-1 87261-A 76B77-9).each do |account|
      subject.destination_account = account
      subject.should_not be_valid
    end

    subject.destination_account = '44124-6'
    subject.should be_valid
  end

  it 'should have distinct source and destination accounts' do
    subject.source_account = subject.destination_account
    subject.should_not be_valid
  end

  it 'should have a greater than zero amount' do
    [nil,-0.1,'0.0',0.0].each do |amount|
      subject.amount = amount
      subject.should_not be_valid
    end

    build(:transfer).should be_valid
  end

  it 'should not have a due date in the past' do
    [nil, Date.today - 1.day].each do |day|
      subject.due_date = day
      subject.should_not be_valid
    end

    [Date.today, Date.today + 1.day].each do |day|
      subject.due_date = day
      subject.should be_valid
    end
  end

  it 'it should have a fee greater than zero' do
    [nil, 0, '0', -0.0001].each do |fee|
      subject.fee = fee
      subject.should_not be_valid
    end
  end

  it 'should have a type' do
    subject.type = nil
    subject.should_not be_valid
  end
end
