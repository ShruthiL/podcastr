class PodcastSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :reviews, :user

  def user
    if scope
      {id: scope.id, userName: scope.user_name, admin: scope.admin}
    else
      {id: nil, userName: nil, admin: nil}
    end
  end

  has_many :reviews
end
