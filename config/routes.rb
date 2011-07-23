Rails.application.routes.draw do
  # Days
  resources :days do
    collection do
      post :calculate_cash
    end
  end
end
