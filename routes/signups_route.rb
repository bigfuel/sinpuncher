class App < Sinatra::Base
  get '/signups' do
    authorize @project, __method__

    params[:sort_direction] ||= "asc"

    @signups = @project.signups
    @signups = @signups.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @signups = @signups.page(params[:page])
    @signups = @signups.per(params[:per_page]) if params[:per_page]

    render :rabl, :'signups/index'
  end

  get '/signups/:id' do
    authorize @project, __method__

    @signup = @project.signups.find(params[:id])

    render :rabl, :'signups/show'
  end

  post '/signups' do
    authorize @project, __method__

    @signup = @project.signups.new(params[:signup])
    params[:signup].each do |k, v|
      @signup[k] = v unless @signup.respond_to?(k)
    end

    if @signup.save
      @signup.complete if @signup[:opt_out]
    end

    render :rabl, :'signups/show'
  end

  patch '/signups/:id' do
    authorize @project, __method__

    @signup = @project.signups.find(params[:id])
    @signup.update_attributes(params[:signup])

    render :rabl, :'signups/show'
  end

  delete '/signups/:id' do
    authorize @project, __method__

    @signup = @project.signups.find(params[:id])
    @signup.destroy

    render nothing: true, status: 204
  end
end