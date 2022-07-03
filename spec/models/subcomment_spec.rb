require 'rails_helper'

describe Subcomment, type: :model do

  let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum.") }
  let!(:comment) { FactoryBot.create(:comment, content: "Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.", post_id: post.id) }

  subject {
    described_class.new(content: "Lorem ipsum", comment_id: comment.id)
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without content' do
    subject.content = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without comment_id' do
    subject.comment_id = nil
    expect(subject).to_not be_valid
  end

end
