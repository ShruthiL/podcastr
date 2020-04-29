class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :review

  belongs_to :podcast
end
