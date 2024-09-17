# spec/controllers/api/youtubes_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::YoutubesController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      title: "Sample Video Title",
      description: "Sample Video Description",
      image_url: "http://example.com/sample.jpg",
      video_url: "https://www.youtube.com/watch?v=sampleid"
    }
  end
  let(:invalid_attributes) do
    {
      title: "",
      description: "",
      image_url: "",
      video_url: "invalid_url"
    }
  end

  before do
    allow_any_instance_of(Api::YoutubesController).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    it "returns a successful response with paginated youtubes" do
      youtube = create(:youtube, user: user)
      get :index, params: { page: 1 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].first['title']).to eq(youtube.title)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new Youtube" do
        VCR.use_cassette("youtube_api") do
          post :create, params: { video_url: "https://www.youtube.com/watch?v=sampleid" }
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)['message']).to eq('Video created successfully')
        end
      end
    end

    context "with invalid attributes" do
      it "returns an error for invalid YouTube URL format" do
        post :create, params: { video_url: "invalid_url" }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Invalid YouTube URL format')
      end

      it "returns an error for invalid YouTube URL path" do
        VCR.use_cassette("youtube_api_invalid") do
          post :create, params: { video_url: "https://www.youtube.com/watch?v=invalidid" }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['error']).to eq('Invalid YouTube URL path')
        end
      end
    end
  end
end
