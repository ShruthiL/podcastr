class PodcastSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :reviews
  
  has_many :reviews
end
