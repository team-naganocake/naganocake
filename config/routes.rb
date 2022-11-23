Rails.application.routes.draw do

  namespace :admin do
    # get 'customers/index'
    # get 'customers/show'
    # get 'customers/edit'

    #【admin/customersコントローラー】
    get 'customers' => 'customers#index'
    get 'customers/:id' => 'customers#show'
    get 'customers/:id/edit' => 'customers#edit'
    patch 'customers/:id'=> 'customers#update'
  end


  # namespace :public doと記述されていたのをscope module:を使うことによって、URLに"public"が表示されないようにした。
  scope module: :public do
    # get 'customers/show'
    # get 'customers/edit'
    # get 'customers/unsubscribe'

    #【public/customersコントローラー】
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
  end




  # devise_for :admins(下記のように書き換え)
  # devise_for :customers（下記のように書き換え）
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 【顧客用】
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # 【管理者用】
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  root to: "public/homes#top"
  get '/about' => "public/homes#about", as:'about'


end
