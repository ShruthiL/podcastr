class Api::V1::PodcastsController < ApplicationController
    before_action :authorize_user, except: [:index, :show]

    def index
        render json: Podcast.all
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

    def authorize_user
        if !user_signed_in?
          raise ActionController::RoutingError.new("Not Found")
        end
      end
end