class Api::V1::PodcastsController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }

    def index
        podcast = Podcast.all
        render json: {
            podcast: podcast,
            user: serialized_data(current_user, UserSerializer)
        }
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

    private

    def podcast_params
        params.require(:podcast).permit(:name, :url)
    end

    def serialized_data(data, serializer)
        ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer)
    end
end
