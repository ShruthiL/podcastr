class Api::V1::ReviewsController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }

    def create
        review = Review.new(review_params)
        if review.save
            render json: { review: review }
        else
            render json: { error: podcast.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def review_params
        params.require(:review).permit(:rating, :review, :user_id, :podcast_id)
    end

end