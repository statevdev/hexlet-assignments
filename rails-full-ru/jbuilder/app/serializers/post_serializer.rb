# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  belongs_to :user

  attributes :id, :title
end
