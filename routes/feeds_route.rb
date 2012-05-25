class App < Sinatra::Base
  get '/feeds' do
    authorize @project, __method__

    params[:sort_direction] ||= "asc"

    @feeds = @project.feeds
    @feeds = @feeds.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @feeds = @feeds.page(params[:page])
    @feeds = @feeds.per(params[:per_page]) if params[:per_page]

    render :rabl, :'feeds/index'
  end

  get '/feeds/:id' do
    authorize @project, __method__

    @feed = @project.feeds.find_by_name(params[:id])

    render :rabl, :'feeds/show'
  end

  post '/feeds' do
    authorize @project, __method__

    @feed = @project.feeds.new(params[:feed])
    @feed.save

    render :rabl, :'feeds/show'
  end

  patch '/feeds/:id' do
    authorize @project, __method__

    @feed = @project.feeds.find_by_name(params[:id])
    @feed.update_attributes(params[:feed])

    render :rabl, :'feeds/show'
  end

  delete '/feeds/:id' do
    authorize @project, __method__

    @feed = @project.feeds.find_by_name(params[:id])
    @feed.destroy

    render nothing: true, status: 204
  end
end