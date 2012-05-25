class App < Sinatra::Base
  get '/facebook_events' do
    authorize @project, __method__

    params[:sort_direction] ||= "asc"

    @facebook_events = @project.facebook_events
    @facebook_events = @facebook_events.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @facebook_events = @facebook_events.page(params[:page])
    @facebook_events = @facebook_events.per(params[:per_page]) if params[:per_page]

    render :rabl, :'facebook_events/index'
  end

  get '/facebook_events/:id' do
    authorize @project, __method__

    @facebook_events = @project.facebook_events.find_by_name(params[:id])

    render :rabl, :'facebook_events/show'
  end

  post '/facebook_events' do
    authorize @project, __method__

    @facebook_event = @project.facebook_events.new(params[:facebook_event])
    @facebook_event.save

    render :rabl, :'facebook_events/show'
  end

  patch '/facebook_events/:id' do
    authorize @project, __method__

    @facebook_event = @project.facebook_events.find_by_name(params[:id])
    @facebook_event.update_attributes(params[:facebook_event])

    render :rabl, :'facebook_events/show'
  end

  delete '/facebook_events/:id' do
    authorize @project, __method__

    @facebook_event = @project.facebook_events.find_by_name(params[:id])
    @facebook_event.destroy

    render nothing: true, status: 204
  end
end