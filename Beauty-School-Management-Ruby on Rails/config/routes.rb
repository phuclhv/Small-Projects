Rails.application.routes.draw do
  root    'static_pages#home'
  get     '/help',            to: 'static_pages#help'
  get     '/about',           to: 'static_pages#about'
  get     '/contacts',        to: 'contacts#new',                 via: 'get'
  get     '/signup',          to: 'users#new'
  post    '/signup',          to: 'users#create'
  get     '/login',           to: 'sessions#new'
  post    '/login',           to: 'sessions#create'
  delete  '/logout',          to: 'sessions#destroy'
  get     '/enroll_school',   to: 'school_users#new'
  post    '/enroll_school',   to: 'school_users#create'
  get     '/enroll_program',  to: 'program_enrollments#new'
  post    '/enroll_program',  to: 'program_enrollments#create'
  get     '/contact_info',    to: 'addresses#new'
  post    '/contact_info',    to: 'addresses#create'
  get     '/load_lesson',     to: 'student_lessons#load_lesson'
  get     '/study',           to: 'study_sessions#new'
  post    '/study',           to: 'study_sessions#create'
  get     '/load_exam',       to: 'study_sessions#load_exam'
  post    '/submit_Exam',     to: 'study_sessions#submit_Exam'
  get     '/web_charge',      to: 'web_charges#new'
  post    '/web_charge',      to: 'web_charge#create'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :schools
  resources :school_users
  resources :timecards
  resources :study_programs
  resources :program_enrollments
  resources :addresses
  resources :lessons
  resources :student_lessons
  resources :exams
  resources :questions
  resources :charges
  resources :payments
  resources :student_hours
  resources :student_hour_summaries
  resources :contacts, only: [:new, :create]
  resources :exam_results, only: [:index]
#
# Admin tasks
#
  get     '/admin_tasks/enrollment',        to: 'admin_tasks#new_student'
  post    '/admin_tasks/enrollment',        to: 'admin_tasks#create_student'
#
  get     '/admin_tasks/payment',           to: 'admin_tasks#new_payment'
  post    '/admin_tasks/payment',           to: 'admin_tasks#create_payment'
  get     '/admin_tasks/payment_receipt',   to: 'admin_tasks#show_payment_receipt'
  get     '/admin_tasks/payment_history',   to: 'admin_tasks#index_payment_history'
  get     '/get_payments',                  to: 'admin_tasks#get_payments'
#
  get     '/admin_tasks/timecard_index',              to: 'admin_tasks#index_timecard'
  get     '/admin_tasks/get_students_for_timecards',  to: 'admin_tasks#get_students_for_timecards'
  get     '/admin_tasks/get_timecards',               to: 'admin_tasks#get_timecards'
  post    '/admin_tasks/adjust_student_hours',        to: 'admin_tasks#adjust_student_hours'
  get     '/admin_tasks/clock_out',                   to: 'admin_tasks#clock_out_students'
  post    '/admin_tasks/delete_timecards',            to: 'admin_tasks#delete_timecards'
  post    '/admin_tasks/process_student_hours',       to: 'admin_tasks#process_student_hours'
  post    '/admin_tasks/rollback_student_hours',      to: 'admin_tasks#rollback_student_hours'
  get     '/admin_tasks/show_monthly_student_report', to: 'admin_tasks#show_monthly_student_report'
  get     '/admin_tasks/graduate_students',           to: 'admin_tasks#graduate_students'
#
  get     '/admin_tasks/user_index',                  to: 'admin_tasks#index_user'
  post    '/admin_tasks/activate_user',               to: 'admin_tasks#activate_user'
#
  post    '/admin_tasks/reset_password',              to: 'admin_tasks#reset_password'
#
  get     '/admin_tasks/student_index',               to: 'admin_tasks#index_student'
  get     '/admin_tasks/student_study_program_index', to: 'admin_tasks#index_student_study_program'
  get     '/admin_tasks/get_enrollment_info',         to: 'admin_tasks#get_enrollment_info'
  post    '/admin_tasks/update_study_program',        to: 'admin_tasks#update_study_program'
  post    '/admin_tasks/adjust_tuition',              to: 'admin_tasks#adjust_tuition'
end
