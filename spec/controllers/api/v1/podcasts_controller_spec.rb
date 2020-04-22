require "rails_helper"

RSpec.describe Api::V1::PodcastsController, type: :controller do
  describe "GET#index" do
    let!(:podcast1) { Podcast.create(
        name: "podcast1",
        url: "www.podcast1.com")
    }

    let!(:podcast2) { Podcast.create(
        name: "podcast2",
        url: "www.podcast2.com")
    }

    it "returns a successful response status and a content type of json" do
        get :index

        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
    end

    it "returns all podcasts in the database" do
        get :index
        response_body = JSON.parse(response.body)

        expect(response_body.length).to eq 2

        expect(response_body[0]["name"]).to eq podcast1.name
        expect(response_body[0]["url"]).to eq podcast1.url

        expect(response_body[1]["name"]).to eq podcast2.name
        expect(response_body[1]["url"]).to eq podcast2.url
    end
  end
end
