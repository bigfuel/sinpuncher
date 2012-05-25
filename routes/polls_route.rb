class App < Sinatra::Base
  get '/polls' do
    authorize @project, __method__

    params[:sort_direction] ||= "asc"

    @polls = @project.polls
    @polls = @polls.where(state: params[:state]) if params[:state]
    @polls = @polls.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @polls = @polls.page(params[:page])
    @polls = @polls.per(params[:per_page]) if params[:per_page]

    render :rabl, :'polls/index'
  end

  get '/polls/:id' do
    authorize @project, __method__

    @poll = @project.polls.find(params[:id])

    render :rabl, :'polls/show'
  end

  post '/polls' do
    authorize @project, __method__

    @poll = @project.polls.new(params[:poll])
    @poll.save

    render :rabl, :'polls/show'
  end

  patch '/polls/:id' do
    authorize @project, __method__

    @poll = @project.polls.find(params[:id])
    @poll.update_attributes(params[:poll])

    render :rabl, :'polls/show'
  end

  delete '/polls/:id' do
    authorize @project, __method__

    @poll = @project.polls.find(params[:id])
    @poll.destroy

    render nothing: true, status: 204
  end

  patch '/polls/:id/activate' do
    authorize @project, __method__

    @poll = @project.polls.find(params[:id])
    @poll.activate

    render :rabl, :'polls/show'
  end

  patch '/polls/:id/deactivate' do
    authorize @project, __method__

    @poll = @project.polls.find(params[:id])
    @poll.deactivate

    render :rabl, :'polls/show'
  end

  patch '/polls/:id/vote' do
    poll = @project.polls.active.find(params[:id])
    poll.vote(params['choice']['id'])

    respond_with @poll
  end
end