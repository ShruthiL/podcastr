require "rails_helper"

RSpec.describe Api::V1::ReviewsController, type: :controller do

  describe "POST#new" do
    let!(:podcast1) { Podcast.create(
        name: "podcast1",
        url: "http://www.podcast1.com")
    }

    let!(:user1) { User.create(
      email: "email@email.com",
      user_name: "user1",
      password: "password")
    }

    it "creates a new review record" do

      let!(:new_review_hash) { { review: { rating: 5, review: "Great podcast!", user: user1, podcast: podcast1 } } }

      previous_count = Review.count
      post :create, params: new_review_hash, format: :json
      new_count = Review.count

      expect(new_count).to eq(previous_count + 1)
    end

    it "returns the new review as json" do
      post :create, params: new_review_hash, format: :json

      response_body = JSON.parse(response.body)

      expect(response_body["review"].length).to eq 2
      expect(response_body["review"]["rating"]).to eq 5
      expect(response_body["review"]["review"]).to eq "Great podcast!"
    end

    # context "when a malformed request is made" do
    #   let!(:bad_review_hash_1) { { review: { url: "https://gimletmedia.com/shows/reply-all" } } }
    #   let!(:bad_review_hash_2) { { review: { name: "Reply All" } } }
    #   let!(:bad_review_hash_3) { { review: { name: "Reply All", url: "gimletmedia.com" } } }
    #   let!(:bad_review_hash_4) { { review: { name: "Reply All", url: "https://gimletmedia.com/shows/reply-all" } } }
    #   let!(:bad_review_hash_5) { { review: { name: "", url: "" } } }

    #   it "does not create a new review and return error if review name is not provided" do
    #     previous_count = review.count
    #     post :create, params: bad_review_hash_1, format: :json
    #     new_count = Review.count
    #     response_body = JSON.parse(response.body)

    #     expect(new_count).to eq previous_count
    #     expect(response_body["error"][0]).to eq "Name can't be blank"
    #   end

    #   it "does not create a new review and return error if review url is not provided" do
    #     previous_count = Review.count
    #     post :create, params: bad_review_hash_2, format: :json
    #     new_count = Review.count
    #     response_body = JSON.parse(response.body)

    #     expect(new_count).to eq previous_count
    #     expect(response_body["error"][0]).to eq "Url can't be blank"
    #   end

    #   it "returns an error if name and url are blank" do
    #     post :create, params: bad_review_hash_5, format: :json
    #     response_body = JSON.parse(response.body)

    #     expect(response_body["error"][0]).to eq "Name can't be blank"
    #     expect(response_body["error"][1]).to eq "Url can't be blank"
    #   end

    #   it "returns an error if url does not include http protocol" do
    #     post :create, params: bad_review_hash_3, format: :json
    #     response_body = JSON.parse(response.body)

    #     expect(response_body["error"][0]).to eq "Url is invalid"
    #   end

    #   it "returns an error if url is not unique" do
    #     post :create, params: bad_review_hash_4, format: :json
    #     post :create, params: bad_review_hash_4, format: :json
    #     response_body = JSON.parse(response.body)

    #     expect(response_body["error"][0]).to eq "Url has already been taken"
    #   end
    # end
  end
end
