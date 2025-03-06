# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'

  # BEGIN
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy], module: :posts
  end
  # END
end
