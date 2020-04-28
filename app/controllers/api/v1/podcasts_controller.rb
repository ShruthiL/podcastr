class Api::V1::PodcastsController < ApplicationController
    def index
        render json: Podcast.all
    end

    def show
        podcast = Podcast.find(params[:id])
        render json: {
            podcast: serialized_data(podcast, PodcastSerializer)
        }
    end

    def serialized_data(data, serializer)
        ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer)
    end
end