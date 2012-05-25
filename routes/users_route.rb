class App < Sinatra::Base
  get '/users' do
    @users = User.page(params[:page])

    render :rabl, :'users/index'
  end

  get '/users/:id' do
    @user = User.find(params[:id])

    render :rabl, :'users/show'
  end

  post '/users' do
    @user = User.new(params[:user])
    @user.save

    render :rabl, :'users/show'
  end

  patch '/users/:id' do
    @user = Users.find(params[:id])
    @user.update_attributes(params[:user])

    render :rabl, :'users/show'
  end

  delete '/users/:id' do
    @user = Users.find(params[:id])
    @user.destroy

    render nothing: true, status: 204
  end
end