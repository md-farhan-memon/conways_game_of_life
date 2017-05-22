Rails.application.routes.draw do
  root 'world#home'

  resources :world, :path => "/" do
    collection do
      get 'playground' => 'world#playground'
      post 'grid_size' => 'world#grid_size'
      # post  'grid' => 'world#grid'
      post 'start' => 'world#start' 
      post 'clear' => 'world#clear' 
    end
  end
end
