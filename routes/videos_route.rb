class App < Sinatra::Base
  get '/videos' do
    authorize @project, __method__

    params[:sort_direction] ||= "asc"

    @videos = @project.videos
    @videos = @videos.where(state: params[:state]) if params[:state]
    @videos = @videos.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @videos = @videos.page(params[:page])
    @videos = @videos.per(params[:per_page]) if params[:per_page]

    render :rabl, :'videos/index'
  end

  get '/videos/:id' do
    authorize @project, __method__

    @video = @project.videos.find(params[:id])

    render :rabl, :'videos/show'
  end

  post '/videos' do
    authorize @project, __method__

    @video = @project.videos.new(params[:video])
    @video.save

    render :rabl, :'videos/show'
  end

  patch '/videos/:id' do
    authorize @project, __method__

    @video = @project.videos.find(params[:id])
    @video.update_attributes(params[:video])

    render :rabl, :'videos/show'
  end

  delete '/videos/:id' do
    authorize @project, __method__

    @video = @project.videos.find(params[:id])
    @video.destroy

    render nothing: true, status: 204
  end

  patch '/videos/:id/approve' do
    authorize @project, __method__

    @video = @project.videos.find(params[:id])
    @video.approve

    render :rabl, :'videos/show'
  end

  patch '/videos/:id/deny' do
    authorize @project, __method__

    @video = @project.videos.find(params[:id])
    @video.deny

    render :rabl, :'videos/show'
  end
end