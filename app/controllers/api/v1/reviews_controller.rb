class Api::V1::ReviewsController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }

end