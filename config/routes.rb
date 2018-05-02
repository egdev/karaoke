Rails.application.routes.draw do
  resources :contributors, except: [ :show ]
  resources :singers, except: [ :show ]
  resources :songs, except: [ :show ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'playlists#index'
  
  resources :playlists do
    resources :items, controller: :playlist_item do
      collection do
        patch 'sort'
      end
      
      patch 'watched'

    end
  end
    
end
