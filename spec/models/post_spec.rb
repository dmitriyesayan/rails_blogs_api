require 'rails_helper'

describe Post, type: :model do
  subject {
    described_class.new(content: "Lorem ipsum")
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without content' do
    subject.content = nil
    expect(subject).to_not be_valid
  end
end
