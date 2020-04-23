class Api::V1::PodcastsController < ApplicationController

    protect_from_forgery unless: -> { request.format.json? }
    
    def index
        render json: Podcast.all
    end

    def create
        podcast = Podcast.new(name: params["podcast"]["name"], url: params["podcast"]["url"])
        if podcast.save
            render json: { podcast: podcast }
        else
            render json: { error: podcast.errors.full_messages }, status: :unprocessable_entity
        end
    end
end