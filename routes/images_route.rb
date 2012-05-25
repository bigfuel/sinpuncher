class App < Sinatra::Base
  get '/images' do
    authorize @project, __method__

    params[:sort_direction] ||= "asc"

    @images = @project.images
    @images = @images.where(state: params[:state]) if params[:state]
    @images = @images.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @images = @images.page(params[:page])
    @images = @images.per(params[:per_page]) if params[:per_page]

    render :rabl, :'images/index'
  end

  get '/images/:id' do
    authorize @project, __method__

    @image = @project.images.find(params[:id])

    render :rabl, :'images/show'
  end

  post '/images' do
    authorize @project, __method__

    @image = @project.images.new(params[:image])
    @image.save

    render :rabl, :'images/show'
  end

  patch '/images/:id' do
    authorize @project, __method__

    @image = @project.images.find(params[:id])
    @image.update_attributes(params[:image])

    render :rabl, :'images/show'
  end

  delete '/images/:id' do
    authorize @project, __method__

    @image = @project.images.find(params[:id])
    @image.destroy

    render nothing: true, status: 204
  end

  patch '/images/:id/approve' do
    authorize @project, __method__

    @image = @project.images.find(params[:id])
    @image.approve

    render :rabl, :'images/show'
  end

  patch '/images/:id/deny' do
    authorize @project, __method__

    @image = @project.images.find(params[:id])
    @image.deny

    render :rabl, :'images/show'
  end
end