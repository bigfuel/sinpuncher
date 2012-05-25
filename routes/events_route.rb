class App < Sinatra::Base
  get '/events' do
    authorize @project, __method__

    params[:sort_direction] ||= "asc"

    @events = @project.events
    @events = @events.where(state: params[:state]) if params[:state]
    @events = @events.any_in(type: params[:type].split(",")) if params[:type]
    @events = @events.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @events = @events.page(params[:page])
    @events = @events.per(params[:per_page]) if params[:per_page]

    render :rabl, :'events/index'
  end

  get '/events/:id' do
    authorize @project, __method__

    @event = @project.events.find(params[:id])

    render :rabl, :'events/show'
  end

  post '/events' do
    authorize @project, __method__

    @event = @project.events.new(params[:event])
    @event.save
    @event.move_to_top if @event.save

    render :rabl, :'events/show'
  end

  patch '/events/:id' do
    authorize @project, __method__

    @event = @project.events.find(params[:id])
    @event.update_attributes(params[:event])

    render :rabl, :'events/show'
  end

  delete '/events/:id' do
    authorize @project, __method__

    @event = @project.events.find(params[:id])
    @event.destroy

    render nothing: true, status: 204
  end

  patch '/events/:id/approve' do
    authorize @project, __method__

    @event = @project.events.find(params[:id])
    @event.approve

    render :rabl, :'events/show'
  end

  patch '/events/:id/deny' do
    authorize @project, __method__

    @event = @project.events.find(params[:id])
    @event.deny

    render :rabl, :'events/show'
  end
end