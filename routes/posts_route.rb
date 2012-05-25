class App < Sinatra::Base
  get '/posts' do
    authorize @project, __method__

    params[:sort_direction] ||= "asc"

    @posts = @project.posts
    @posts = @posts.where(state: params[:state]) if params[:state]
    @posts = @posts.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @posts = @posts.has_images if params[:has_images]
    @posts = @posts.tags_tagged_with(params[:tags]) if params[:tags]
    @posts = @posts.page(params[:page])
    @posts = @posts.per(params[:per_page]) if params[:per_page]

    render :rabl, :'posts/index'
  end

  get '/posts/:id' do
    authorize @project, __method__

    @post = @project.posts.find(params[:id])

    render :rabl, :'posts/show'
  end

  post '/posts' do
    authorize @project, __method__

    @post = @project.posts.new(params[:post])
    @post.save

    render :rabl, :'posts/show'
  end

  patch '/posts/:id' do
    authorize @project, __method__

    @post = @project.posts.find(params[:id])
    @post.update_attributes(params[:post])

    render :rabl, :'posts/show'
  end

  delete '/posts/:id' do
    authorize @project, __method__

    @post = @project.posts.find(params[:id])
    @post.destroy

    render nothing: true, status: 204
  end

  patch '/posts/:id/approve' do
    authorize @project, __method__

    @post = @project.posts.find(params[:id])
    @post.approve

    render :rabl, :'posts/show'
  end

  patch '/posts/:id/deny' do
    authorize @project, __method__

    @post = @project.posts.find(params[:id])
    @post.deny

    render :rabl, :'posts/show'
  end
end