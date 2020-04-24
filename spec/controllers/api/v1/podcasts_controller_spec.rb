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

  describe "GET#show" do
    let!(:podcast1) { Podcast.create(
        name: "podcast1",
        url: "www.podcast1.com")
    }

    let!(:podcast2) { Podcast.create(
        name: "podcast2",
        url: "www.podcast2.com")
    }

    it "returns a successful response status and a content type of json" do
        get :show, params: {id: podcast1.id}

        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
    end

    it "returns the specified podcast name and podcast url" do
        get :show, params: {id: podcast1.id}
        response_body = JSON.parse(response.body)

        expect(response_body.length).to eq 5

        expect(response_body["name"]).to eq podcast1.name
        expect(response_body["url"]).to eq podcast1.url

        expect(response_body["name"]).to_not eq podcast2.name
        expect(response_body["url"]).to_not eq podcast2.url
    end
  end

  describe "POST#new" do
    let!(:new_podcast_hash) { { podcast: { name: "Reply All", url: "https://gimletmedia.com/shows/reply-all" } } }

    it "creates a new Podcast record" do
        previous_count = Podcast.count
        post :create, params: new_podcast_hash, format: :json
        new_count = Podcast.count

        expect(new_count).to be (previous_count + 1)
    end

    it "returns the new Podcast as json" do
        post :create, params: new_podcast_hash, format: :json

        response_body = JSON.parse(response.body)

        expect(response_body["podcast"].length).to eq 5
        expect(response_body["podcast"]["name"]).to eq "Reply All"
        expect(response_body["podcast"]["url"]).to eq "https://gimletmedia.com/shows/reply-all"
    end

    context "when a malformed request is made" do
        let!(:bad_podcast_hash_1) { { podcast: { url: "https://gimletmedia.com/shows/reply-all" } } }
        let!(:bad_podcast_hash_2) { { podcast: { name: "Reply All" } } }

        it "returns an error if podcast name is not provided" do
            previous_count = Podcast.count
            post :create, params: bad_podcast_hash_1, format: :json
            new_count = Podcast.count

            expect(new_count).to eq previous_count
        end

        it "returns an error if podcast url is not provided" do
            previous_count = Podcast.count
            post :create, params: bad_podcast_hash_2, format: :json
            new_count = Podcast.count

            expect(new_count).to eq previous_count
        end

        it "returns vaidation errors" do
            post :create, params: bad_podcast_hash_1, format: :json
            response_body = JSON.parse(response.body)

            expect(response_body["error"][0]).to eq "Name can't be blank"
        end
    end
  end
end
