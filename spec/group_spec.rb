require 'rails_helper'

RSpec.describe Group, type: :model do
  subject do
    user = User.create! name: 'john', email: 'john@test.com', password: '123456'
    Group.create! name: 'sports', user:
  end

  it 'test if transaction is invalid without a name' do
    expect(subject).to be_valid
  end

  it 'test if transaction is invalid without a user' do
    expect(subject).to be_valid
    subject.user = nil
    expect(subject).to be_invalid
  end

  it 'test if transaction has a valid name' do
    expect(subject).to be_valid
  end

  it 'test if transaction is invalid without a name' do
    expect(subject).to be_valid
    subject.name = nil
    expect(subject).to be_invalid
  end

  it 'test if transaction is invalid without a name' do
    expect(subject).to be_valid
    subject.name = ''
    expect(subject).to be_invalid
  end

  it 'test if transaction is invalid without a name' do
    expect(subject).to be_valid
    subject.name = 'sports'
    expect(subject).to be_valid
  end
end
