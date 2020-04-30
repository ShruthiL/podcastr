class PodcastSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :reviews, :user
  
  def user
    {id: scope.id, userName: scope.user_name, admin: scope.admin}
  end

  has_many :reviews
end
