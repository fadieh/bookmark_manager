get '/users/new' do
	@user = User.new
	erb :"users/new"
end

post '/users' do
	@user = User.create(:email => params[:email],
						:password => params[:password],
						:password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end

get '/users/reset_password' do
	erb :"users/reset_password"
end

post '/users/reset_password' do
	user = User.first(:email => params[:email])
	if user
		user.update_token
		user.send_reset_email
		flash[:notice] = "Your email is on it's way to you!"
	else
		flash[:notice] = "Sorry we do not recognise that email address. Please try again."
	end
end