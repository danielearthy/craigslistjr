enable :sessions

#HOMEPAGE displays categories if logged in else redirects to login
get '/' do
  if current_user 
    @categories = Category.all
    erb :index
  else
    
    redirect '/session/new'
  end
end

#SESSION

get '/session/new' do
  erb :sign_in
end

get '/session/logout' do
  flash[:goodbye] = "Thanks for stopping by!"
  session.clear
  redirect '/'
end

post '/session/new' do
  @user = User.find_by email: params[:email]
  if @user && @user.password == params[:password]
    session[:id] = @user.id
    redirect '/'
  else
    flash[:password_wrong] = "Try Again, Password Wrong"
    erb :sign_in
  end
end

#USER

get '/user/new' do
  erb :sign_up
end

post '/user/new' do
  @user = User.create(params[:user])
  session[:id] = @user.id
  redirect '/'
end

#CATEGORY

get '/category/:id/:title' do
  session[:category_id] = params[:id]
  @posts = Post.where(category_id: params[:id])
  erb :category
end


#ADD CATEGORY
get '/category/new' do
  erb :add_category
end

post '/category/new' do
  Category.create(params[:category])
  redirect'/'
end

#POSTS

get '/post/:id/:title' do
  @post = Post.find(params[:id])
  erb :post
end

#ADD POST

get '/post/new' do
  erb :add_post
end

post '/post/new' do
  Post.create(params[:post])
  @category = Category.find(session[:category_id])
  session[:category_id] = nil
  redirect "/category/#{@category.id}/#{@category.title}"
end




