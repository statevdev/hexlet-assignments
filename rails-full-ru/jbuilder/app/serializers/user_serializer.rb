# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  has_many :posts

  attributes :id, :email, :address, :full_name

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
