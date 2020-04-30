class Api::V1::PodcastsController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }

    def index
        podcast = Podcast.all
        if current_user
            user = ActiveModelSerializers::SerializableResource.new(current_user, each_serializer: UserSerializer)
        else
            user = {user: {id: "", user_name: "", admin: false} }
        end
        render json: {
            podcast: podcast,
            user: user
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
        podcast = Podcast.find(params[:id])
        render json: podcast
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
