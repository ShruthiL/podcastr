class Api::V1::PodcastsController < ApplicationController
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
        render json: Podcast.find(params[:id])
    end

    def destroy
        podcast = Podcast.find(params[:id])
        podcast.destroy
        render json: {}, status: :no_content
    end

    private

    def podcast_params
        params.require(:podcast).permit(:name, :url)
    end
end
