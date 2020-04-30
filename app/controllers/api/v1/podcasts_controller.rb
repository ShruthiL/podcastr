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
        podcast = Podcast.find(params[:id])
        if current_user
            user = serialized_data(current_user, UserSerializer)
        else
            user = {user: {id: "", user_name: "", admin: false} }
        end
        render json: {
            podcast: serialized_data(podcast, PodcastSerializer),
            user: user
        }
    end

    private

    def podcast_params
        params.require(:podcast).permit(:name, :url)
    end

    def serialized_data(data, serializer)
        ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer)
    end
end
