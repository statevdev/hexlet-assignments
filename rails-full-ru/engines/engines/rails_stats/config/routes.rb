# frozen_string_literal: true

RailsStats::Engine.routes.draw do
  # BEGIN
  root 'stats#index'
  resources :stats, only: :index
  # END
end
