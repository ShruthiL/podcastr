class Api::V1::PodcastsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    protect_from_forgery unless: -> { request.format.json? }

    def index
        render json: Podcast.all
    end

    def create
        podcast = Podcast.new(podcast_params)
        if podcast.save
            render json: { podcast: podcast }
        else
            render json: { error: podcast.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        podcast = Podcast.find(params[:id])
        user = current_user
        response_body = []
        response_body.push(user)
        response_body.push(podcast)
        render json: response_body
    end

    private

    def podcast_params
        params.require(:podcast).permit(:name, :url)
    end
end
