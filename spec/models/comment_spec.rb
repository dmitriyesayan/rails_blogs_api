require 'rails_helper'

describe Comment, type: :model do

  let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum.") }

  subject {
    described_class.new(content: "Lorem ipsum", post_id: post.id)
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without content' do
    subject.content = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without post_id' do
    subject.post_id = nil
    expect(subject).to_not be_valid
  end

end
