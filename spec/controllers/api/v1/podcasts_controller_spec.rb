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

    let!(:user1) {User.create(
        first_name: "John",
        last_name:"Smith",
        email: "test@gmail.com",
        password: "password",
        user_name: "testuser")
    }

    let!(:review1) { Review.create(
        rating: 5,
        review: "so good!",
        podcast: podcast1,
        user: user1)
    }

    let!(:review2) { Review.create(
        rating: 4,
        review: "so bad!",
        podcast: podcast2,
        user: user1)
    }

    it "returns a successful response status and a content type of json" do
        get :show, params: {id: podcast1.id}

        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
    end

    it "returns the specified podcast name and podcast url" do
        get :show, params: {id: podcast1.id}
        response_body = JSON.parse(response.body)
        
        expect(response_body.length).to eq 1

        expect(response_body["podcast"]["name"]).to eq podcast1.name
        expect(response_body["podcast"]["url"]).to eq podcast1.url
        expect(response_body["podcast"]["reviews"][0]["review"]).to eq review1.review
        expect(response_body["podcast"]["reviews"][0]["rating"]).to eq review1.rating

        expect(response_body["podcast"]["name"]).to_not eq podcast2.name
        expect(response_body["podcast"]["url"]).to_not eq podcast2.url
        expect(response_body["podcast"]["reviews"][0]["review"]).to_not eq review2.review
        expect(response_body["podcast"]["reviews"][0]["rating"]).to_not eq review2.rating 
    end
  end
end
