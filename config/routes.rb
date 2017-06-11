# frozen_string_literal: true

Rails.application.routes.draw do
  root 'world#home'

  resources :world, only: [] do
    collection do
      get 'playground' => 'world#playground'
      post 'start' => 'world#start'
      post 'clear' => 'world#clear'
    end
  end
end
