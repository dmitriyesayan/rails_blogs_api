require 'rails_helper'

describe 'COMMENTS API', type: :request do
  describe 'GET /posts/:id/comments' do

    let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.") }
    it 'return all comments' do
      FactoryBot.create(:comment, content: "Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.", post_id: post.id)
      FactoryBot.create(:comment, content: "Vestibulum faucibus ex tellus, in dapibus diam sagittis eu. Sed.", post_id: post.id)

      get "/api/v1/posts/#{post.id}/comments"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end

  end


  describe 'GET /posts/:id/comments/:id' do
    let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.") }
    let!(:comment) { FactoryBot.create(:comment, content: "Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.", post_id: post.id) }
    it 'return a comment' do

      get "/api/v1/posts/#{post.id}/comments/#{comment.id}"

      expect(response).to have_http_status(:success)
      expect(response.body).to eq("{\"id\":#{comment.id},\"content\":\"Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.\",\"post_id\":#{post.id},\"subcomments\":[]}")
    end
  end

  describe 'POST /posts/:id/comments' do

    let!(:post_renamed) { FactoryBot.create(:post, content: "Lorem ipsum.") }

    it 'create a new comment' do
      expect {
        post "/api/v1/posts/#{post_renamed.id}/comments", params: { comment: { content: "Etiam sodales commodo dui"}}
    }.to change { Post.find(post_renamed.id).comments.count }.from(0).to(1)

      expect(response).to have_http_status(:success)
    end

    it 'create a new comment with blank content fails' do

      post "/api/v1/posts/#{post_renamed.id}/comments", params: { comment: { content: ""}}

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH /posts/:id/comments/:id' do
    let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum.") }
    let!(:comment) { FactoryBot.create(:comment, content: "Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.", post_id: post.id) }
    it "update a comment" do

      patch "/api/v1/posts/#{post.id}/comments/#{comment.id}", params: { comment: { content: "Updated content"}}

      expect(response).to have_http_status(:success)
      expect(response.body).to eq("{\"id\":#{comment.id},\"content\":\"Updated content\",\"post_id\":#{post.id},\"subcomments\":[]}")

    end
  end

  describe 'DELETE /posts/:id/comments/:id' do
    let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.") }
    let!(:comment) { FactoryBot.create(:comment, content: "Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.", post_id: post.id) }
    let!(:subcomment) { FactoryBot.create(:subcomment, content: "Vestibulum faucibus ex tellus, in dapibus diam sagittis eu. Sed.", comment_id: comment.id) }

    it 'delete a comment' do
      expect {
        delete "/api/v1/posts/#{post.id}/comments/#{comment.id}"
    }.to change { Post.find(post.id).comments.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end

    it 'deleting a comment deletes all the subcomments belonging to the comment' do
      delete "/api/v1/posts/#{post.id}/comments/#{comment.id}"
      expect(Subcomment.find_by(comment_id: comment.id)).not_to be_present
    end
  end

end
