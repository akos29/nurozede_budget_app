require 'rails_helper'

RSpec.describe Expense, type: :model do
  subject do
    user = User.create! name: 'john', email: 'john@test.com', password: '123456'
    Expense.create! name: 'wall street land', amount: 2_000_000, user: user
  end

  it 'test if Expense is invalid without a name' do
    expect(subject).to be_valid
  end

  it 'test if Expense is invalid without a user' do
    expect(subject).to be_valid
    subject.user = nil
    expect(subject).to be_invalid
  end

  it 'test if Expense has a valid amount' do
    expect(subject).to be_valid
  end

  it 'test if Expense is invalid without an amount' do
    expect(subject).to be_valid
    subject.amount = nil
    expect(subject).to be_invalid
  end

  it 'test if Expense is invalid without an amount' do
    expect(subject).to be_valid
    subject.amount = 0
    expect(subject).to be_invalid
  end

  it 'test if Expense is invalid without an amount' do
    expect(subject).to be_valid
    subject.amount = -1
    expect(subject).to be_invalid
  end

  it 'test if Expense is invalid without a amount' do
    expect(subject).to be_valid
    subject.amount = 1
    expect(subject).to be_valid
  end
  
end
