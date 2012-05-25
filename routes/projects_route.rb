class App < Sinatra::Base
  get '/projects' do
    @projects = Project.order_by("name", "asc").page(params[:page])

    render :rabl, :'projects/index'
  end

  get '/projects/:id' do
    @project = Project.find_by_name(params[:id])

    render :rabl, :'projects/show'
  end

  post '/projects' do
    @project = Project.new(params[:project])
    @project.save

    render :rabl, :'projects/show'
  end

  patch '/projects/:id' do
    @project = Project.find_by_name(params[:id])
    @project.update_attributes(params[:project])

    render :rabl, :'projects/show'
  end

  delete '/projects/:id' do
    @project = Project.find_by_name(params[:id])
    @project.destroy

    render nothing: true, status: 204
  end

  patch '/projects/:id/activate' do
    @project = Project.find_by_name(params[:id])
    @project.activate

    render :rabl, :'projects/show'
  end

  patch '/projects/:id/deactivate' do
    @project = Project.find_by_name(params[:id])
    @project.deactivate

    render :rabl, :'projects/show'
  end
end