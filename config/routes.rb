Rails.application.routes.draw do
  # Salaries
  resources :salary_booking_templates do
    member do
      get :copy
    end
  end

  resources :salary_templates

  resources :salaries do
    collection do
      get :select_employee
      get :statistics
    end

    member do
      get :payslip
    end

    # Line Items
    member do
      get :new_line_item
    end
    collection do
      get :new_line_item
    end
  end
end
