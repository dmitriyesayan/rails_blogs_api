require 'rails_helper'

describe 'SUBCOMMENTS API', type: :request do
  describe 'GET /posts/:id/comments/:id/subcomments' do

    let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.") }
    let!(:comment) { FactoryBot.create(:comment, content: "Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.", post_id: post.id) }
    it 'return all subcomments' do
      FactoryBot.create(:subcomment, content: "Esit amet ullamcorper nisi finibus vel.", comment_id: comment.id)
      FactoryBot.create(:subcomment, content: "Vestibulum faucibus ex tellus, in dapibus diam sagittis eu. Sed.", comment_id: comment.id)

      get "/api/v1/posts/#{post.id}/comments/#{comment.id}/subcomments"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end

  end


  describe 'GET /posts/:id/comments/:id/subcomments/:id' do
    let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.") }
    let!(:comment) { FactoryBot.create(:comment, content: "Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.", post_id: post.id) }
    let!(:subcomment) { FactoryBot.create(:subcomment, content: "Vestibulum faucibus ex tellus, in dapibus diam sagittis eu. Sed.", comment_id: comment.id) }
    it 'return a subcomment' do

      get "/api/v1/posts/#{post.id}/comments/#{comment.id}/subcomments/#{subcomment.id}"

      expect(response).to have_http_status(:success)
      expect(response.body).to eq("{\"id\":#{subcomment.id},\"content\":\"Vestibulum faucibus ex tellus, in dapibus diam sagittis eu. Sed.\",\"comment_id\":#{comment.id}}")
    end
  end

  describe 'POST /posts/:id/comments/:id/subcomments' do
    let!(:post_renamed) { FactoryBot.create(:post, content: "Lorem ipsum")}
    let!(:comment) { FactoryBot.create(:comment, content: "Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.", post_id: post_renamed.id) }
    it 'create a new subcomment' do
      expect {
        post "/api/v1/posts/#{post_renamed.id}/comments/#{comment.id}/subcomments", params: { subcomment: { content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."}}
    }.to change { Comment.find(comment.id).subcomments.count }.from(0).to(1)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /posts/:id/comments/:id/subcomments/:id' do
    let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum.") }
    let!(:comment) { FactoryBot.create(:comment, content: "Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.", post_id: post.id) }
    let!(:subcomment) { FactoryBot.create(:subcomment, content: "Vestibulum faucibus ex tellus, in dapibus diam sagittis eu. Sed.", comment_id: comment.id) }
    it "update a subcomment" do

      patch "/api/v1/posts/#{post.id}/comments/#{comment.id}/subcomments/#{subcomment.id}", params: { subcomment: { content: "Updated content"}}

      expect(response).to have_http_status(:success)
      expect(response.body).to eq("{\"id\":#{subcomment.id},\"content\":\"Updated content\",\"comment_id\":#{comment.id}}")

    end
  end

  describe 'DELETE /posts/:id/comments/:id/subcomments/:id' do
    let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.") }
    let!(:comment) { FactoryBot.create(:comment, content: "Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.", post_id: post.id) }
    let!(:subcomment) { FactoryBot.create(:subcomment, content: "Vestibulum faucibus ex tellus, in dapibus diam sagittis eu. Sed.", comment_id: comment.id) }

    it 'delete a subcomment' do
      expect {
        delete "/api/v1/posts/#{post.id}/comments/#{comment.id}/subcomments/#{subcomment.id}"
    }.to change { Comment.find(comment.id).subcomments.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)

    end
  end

end
