class UserSerializer < ActiveModel::Serializer
  attributes :firstname, :lastname, :email
end
