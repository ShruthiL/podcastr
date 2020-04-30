require "rails_helper"

RSpec.describe Api::V1::PodcastsController, type: :controller do
  describe "GET#index" do
    let!(:podcast1) { Podcast.create(
      name: "podcast1",
      url: "http://www.podcast1.com")
    }

    let!(:podcast2) { Podcast.create(
      name: "podcast2",
      url: "http://www.podcast2.com")
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

      expect(response_body["podcast"][0]["name"]).to eq podcast1.name
      expect(response_body["podcast"][0]["url"]).to eq podcast1.url

      expect(response_body["podcast"][1]["name"]).to eq podcast2.name
      expect(response_body["podcast"][1]["url"]).to eq podcast2.url
    end
  end

  describe "GET#show" do
    let!(:podcast1) { Podcast.create(
      name: "podcast1",
      url: "http://www.podcast1.com")
    }

    let!(:podcast2) { Podcast.create(
      name: "podcast2",
      url: "http://www.podcast2.com")
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

      expect(response_body["podcast"].length).to eq 4

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

  describe "POST#new" do
    let!(:new_podcast_hash) { { podcast: { name: "Reply All", url: "https://gimletmedia.com/shows/reply-all" } } }

    it "creates a new Podcast record" do
      previous_count = Podcast.count
      post :create, params: new_podcast_hash, format: :json
      new_count = Podcast.count

      expect(new_count).to eq(previous_count + 1)
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
      let!(:bad_podcast_hash_3) { { podcast: { name: "Reply All", url: "gimletmedia.com" } } }
      let!(:bad_podcast_hash_4) { { podcast: { name: "Reply All", url: "https://gimletmedia.com/shows/reply-all" } } }
      let!(:bad_podcast_hash_5) { { podcast: { name: "", url: "" } } }

      it "does not create a new podcast and return error if podcast name is not provided" do
        previous_count = Podcast.count
        post :create, params: bad_podcast_hash_1, format: :json
        new_count = Podcast.count
        response_body = JSON.parse(response.body)

        expect(new_count).to eq previous_count
        expect(response_body["error"][0]).to eq "Name can't be blank"
      end

      it "does not create a new podcast and return error if podcast url is not provided" do
        previous_count = Podcast.count
        post :create, params: bad_podcast_hash_2, format: :json
        new_count = Podcast.count
        response_body = JSON.parse(response.body)

        expect(new_count).to eq previous_count
        expect(response_body["error"][0]).to eq "Url can't be blank"
      end

      it "returns an error if name and url are blank" do
        post :create, params: bad_podcast_hash_5, format: :json
        response_body = JSON.parse(response.body)

        expect(response_body["error"][0]).to eq "Name can't be blank"
        expect(response_body["error"][1]).to eq "Url can't be blank"
      end

      it "returns an error if url does not include http protocol" do
        post :create, params: bad_podcast_hash_3, format: :json
        response_body = JSON.parse(response.body)

        expect(response_body["error"][0]).to eq "Url is invalid"
      end

      it "returns an error if url is not unique" do
        post :create, params: bad_podcast_hash_4, format: :json
        post :create, params: bad_podcast_hash_4, format: :json
        response_body = JSON.parse(response.body)

        expect(response_body["error"][0]).to eq "Url has already been taken"
      end
    end
  end

  describe '#destroy' do
    let! (:podcast) { Podcast.create(name: "Reply All", url: "http://www.gimletsomething.com") }
    let! (:user) { User.create(
      first_name: "John",
      last_name:"Smith",
      email: "test@gmail.com",
      password: "password",
      user_name: "testuser",
      admin: true
    ) }

    it 'removes podcast from table' do
      sign_in user
      count = Podcast.count
      delete :destroy, params: { id: podcast.id }

      expect(Podcast.count).to eq(count - 1)
    end
  end
end
