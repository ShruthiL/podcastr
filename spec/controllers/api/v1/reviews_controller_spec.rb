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
      sign_in user1
      
      new_review_hash = {
        podcast_id: podcast1.id,
        review: {
          rating: 5,
          review: "Great podcast!",
          user_id: user1.id, 
          podcast_id: podcast1.id
        }
      }

      previous_count = Review.count
      post :create, params: new_review_hash, format: :json
      new_count = Review.count

      expect(new_count).to eq(previous_count + 1)
    end

    it "returns the new review as json" do
      new_review_hash = {
        podcast_id: podcast1.id,
        review: {
          rating: 5,
          review: "Great podcast!",
          user_id: user1.id, 
          podcast_id: podcast1.id
        }
      }

      post :create, params: new_review_hash, format: :json

      response_body = JSON.parse(response.body)

      expect(response_body["review"].length).to eq 7
      expect(response_body["review"]["rating"]).to eq 5
      expect(response_body["review"]["review"]).to eq "Great podcast!"
    end
            
    context "when a malformed request is made" do
      let!(:bad_review_hash_1) { { podcast_id: podcast1.id, review: { review: "blerg" } } }

      it "does not create a new review and return error if review rating is not provided" do
        previous_count = Review.count
        post :create, params: bad_review_hash_1, format: :json
        new_count = Review.count
        response_body = JSON.parse(response.body)

        expect(new_count).to eq previous_count
        expect(response_body["error"][0]).to eq "Rating is not a number"
        expect(response_body["error"][1]).to eq "User can't be blank"
        expect(response_body["error"][2]).to eq "Podcast can't be blank"
        expect(response_body["error"][3]).to eq "User must exist"
      end
    end
  end
end
