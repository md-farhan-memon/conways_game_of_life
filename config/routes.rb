Rails.application.routes.draw do
  root 'world#index'

  resources :world, :path => "/" do
    collection do
      post 'grid_size' => 'world#grid_size'
      # post  'grid' => 'world#grid'
      post 'start' => 'world#start' 
      post 'clear' => 'world#clear' 
    end
  end
end
