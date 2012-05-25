class App < Sinatra::Base
  get '/submissions' do
    authorize @project, __method__

    params[:sort_direction] ||= "asc"

    @submissions = @project.submissions
    @submissions = @submissions.where(state: params[:state]) if params[:state]
    @submissions = @submissions.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @submissions = @submissions.page(params[:page])
    @submissions = @submissions.per(params[:per_page]) if params[:per_page]

    render :rabl, :'submissions/index'
  end

  get '/submissions/:id' do
    authorize @project, __method__

    @submission = @project.submissions.find(params[:id])

    render :rabl, :'submissions/show'
  end

  post '/submissions' do
    authorize @project, __method__

    @submission = @project.submissions.new(params[:submission])
    @submission.save

    render :rabl, :'submissions/show'
  end

  patch '/submissions/:id' do
    authorize @project, __method__

    @submission = @project.submissions.find(params[:id])
    @submission.update_attributes(params[:submission])

    render :rabl, :'submissions/show'
  end

  delete '/submissions/:id' do
    authorize @project, __method__

    @submission = @project.submissions.find(params[:id])
    @submission.destroy

    render nothing: true, status: 204
  end

  patch '/submissions/:id/approve' do
    authorize @project, __method__

    @submission = @project.submissions.find(params[:id])
    @submission.approve

    render :rabl, :'submissions/show'
  end

  patch '/submissions/:id/deny' do
    authorize @project, __method__

    @submission = @project.submissions.find(params[:id])
    @submission.deny

    render :rabl, :'submissions/show'
  end
end