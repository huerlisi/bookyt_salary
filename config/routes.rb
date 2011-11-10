Rails.application.routes.draw do
  # Salaries
  resources :salaries do
    collection do
      get :statistics
    end

    member do
      get :payslip
    end
  end
end
