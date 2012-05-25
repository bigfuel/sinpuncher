class App < Sinatra::Base
  get '/permissions' do
    @permissions = @project.permissions

    render :rabl, :'permissions/index'
  end

  get '/permissions/:id' do
    @permission = @project.permissions.find(params[:id])

    render :rabl, :'permissions/show'
  end

  post '/permissions' do
    @permission = @project.permissions.new(params[:permission])
    @permission.save

    render :rabl, :'permissions/show'
  end

  patch '/permissions/:id' do
    @permission = @project.permissions.find(params[:id])
    @permission.update_attributes(params[:permission])

    render :rabl, :'permissions/show'
  end

  delete '/permissions/:id' do
    @permission = @project.permissions.find(params[:id])
    @permission.destroy

    render nothing: true, status: 204
  end
end