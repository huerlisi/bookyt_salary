Rails.application.routes.draw do
  # Salaries
  resources :salary_booking_templates do
    member do
      get :copy
    end
    collection do
      get :statistics
    end
  end

  resources :salary_templates do
    member do
      get :copy
      get :new_salary_item
    end
    collection do
      get :new_salary_item
    end
  end

  resources :salaries do
    collection do
      get :select_employee
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

   get 'salary_reports/:action', :controller => :salary_reports
   get 'salary_reports/salary_declaration', :to => 'salary_reports#salary_declaration', :as => :salary_declaration
end
