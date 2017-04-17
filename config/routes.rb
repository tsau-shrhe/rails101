Rails.application.routes.draw do
  devise_for :users
  resources :groups
  root 'groups#index'
  # 指向 views\welcome資料夾裡的index.html.erb
  # root 'welcome#index'
end
