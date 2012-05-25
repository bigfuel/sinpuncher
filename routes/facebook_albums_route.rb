class App < Sinatra::Base
  get '/facebook_albums' do
    authorize @project, __method__

    params[:sort_direction] ||= "asc"

    @facebook_albums = @project.facebook_albums
    @facebook_albums = @facebook_albums.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @facebook_albums = @facebook_albums.page(params[:page])
    @facebook_albums = @facebook_albums.per(params[:per_page]) if params[:per_page]

    render :rabl, :'facebook_albums/index'
  end

  get '/facebook_albums/:id' do
    authorize @project, __method__

    @facebook_album = @project.facebook_albums.find_by_name(params[:id])

    render :rabl, :'facebook_albums/show'
  end

  post '/facebook_albums' do
    authorize @project, __method__

    @facebook_album = @project.facebook_albums.new(params[:facebook_album])
    @facebook_album.save

    render :rabl, :'facebook_albums/show'
  end

  patch '/facebook_albums/:id' do
    authorize @project, __method__

    @facebook_album = @project.facebook_albums.find_by_name(params[:id])
    @facebook_album.update_attributes(params[:facebook_album])

    render :rabl, :'facebook_albums/show'
  end

  delete '/facebook_albums/:id' do
    authorize @project, __method__

    @facebook_album = @project.facebook_albums.find_by_name(params[:id])
    @facebook_album.destroy

    render nothing: true, status: 204
  end
end