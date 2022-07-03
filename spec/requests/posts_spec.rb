require 'rails_helper'

describe 'POSTS API', type: :request do
  describe 'GET /posts' do

    it 'return all posts' do
      FactoryBot.create(:post, content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
      FactoryBot.create(:post, content: "Etiam sodales commodo dui, sit amet ullamcorper nisi finibus vel.")
      FactoryBot.create(:post, content: "Vestibulum faucibus ex tellus, in dapibus diam sagittis eu. Sed.")

      get '/api/v1/posts'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(3)
    end

  end


  describe 'GET /posts/:id' do
    let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.") }
    it 'return a post' do

      get "/api/v1/posts/#{post.id}"

      expect(response).to have_http_status(:success)
      expect(response.body).to eq("{\"id\":#{post.id},\"content\":\"#{post.content}\",\"comments\":[]}")
    end
  end

  describe 'POST /posts' do
    it 'create a new post' do
      expect {
        post '/api/v1/posts', params: { post: { content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."}}
    }.to change { Post.count }.from(0).to(1)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /posts/:id' do
    let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum.") }

    it "update a post" do

      patch "/api/v1/posts/#{post.id}", params: { post: { content: "Updated content"}}

      expect(response).to have_http_status(:success)
      expect(response.body).to eq("{\"id\":#{post.id},\"content\":\"Updated content\",\"comments\":[]}")

    end
  end

  describe 'DELETE /posts/:id' do
    let!(:post) { FactoryBot.create(:post, content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.") }

    it 'delete a post' do
      expect {
        delete "/api/v1/posts/#{post.id}"
    }.to change { Post.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)

    end
  end

end
