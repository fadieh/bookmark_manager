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
		redirect to('/users/reset_password')
	else
		flash[:notice] = "Sorry we do not recognise that email address. Please try again."
	end
end

get '/users/change_password/:token/:email' do
	user = User.first(:email => params[:email])
	@user = user
	if params[:token] == user.password_token
		erb :"users/change_password"
	else
		flash[:notice] = "You do not have "
	end
end

post '/users/change_password' do
	user = User.first(:email => params[:email])
	if user
		user.update(:password => params[:password],
				:password_confirmation => params[:password_confirmation])
		flash[:notice] = "You have updated your password"
	else
		flash[:notice] = "Sorry, doesn't match"
	end
end