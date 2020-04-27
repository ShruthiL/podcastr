class Api::V1::PodcastsController < ApplicationController
    def index
        render json: Podcast.all
    end

    def show
        podcast = Podcast.find(params[:id])
        render json: {
            podcast: podcast,
            reviews: podcast.reviews
        }
    end
end