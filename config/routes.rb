Rails.application.routes.draw do

  namespace :admin do
    #【admin/genresコントローラー】
    resources :genres, only:[:index, :create, :edit, :update, :destroy]
  end

  namespace :admin do
    #【admin/itemsコントローラー】
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    #ルーティングを書くときは、まずresourcesで書く。そして、＄rails routesで確認し、指定されたURLだけ個別に書いた方がエラーが出にくい。
  end

  namespace :admin do
    #【admin/customersコントローラー】
    get 'customers' => 'customers#index'
    get 'customers/:id' => 'customers#show'
    get 'customers/:id/edit' => 'customers#edit', as:'edit_adim_cutomer'
    patch 'customers/:id'=> 'customers#update'
    # resources :customers
  end


  # namespace :public doと記述されていたのをscope module:を使うことによって、URLに"public"が表示されないようにした。
  scope module: :public do
    #【public/customersコントローラー】
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
  end

  scope module: :public do
    #【public/addressesコントローラー】
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end

  scope module: :public do
    #【pulic/itemsコントローラー】
    resources :items, only:[:index, :show]
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

  #同じpathでメソッドが同じ場合は、名前付きルートにするか、resourcesで書くようにする
  #顧客側のURLで:idがつかないようにしているのは他人の画面に簡単にログインできないようにするため。他に制限をかける方法もあるが…


end
