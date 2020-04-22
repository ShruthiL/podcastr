class Api::V1::PodcastsController < ApplicationController
    def index
        render json: Podcast.all
    end
end