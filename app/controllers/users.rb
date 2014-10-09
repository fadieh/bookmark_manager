get '/users/new' do
	@user = User.new
	# note the view is in views/users/new.erb
	# we need the quotes because otherwise
	# ruby would divide the symbol :users by the
	# variable new (which makes no sense)
	erb :"users/new"
end

post '/users' do
	# we just initialise the object
	# without saving it. It may be invalid
	@user = User.create(:email => params[:email],
						:password => params[:password],
						:password_confirmation => params[:password_confirmation])
	# lets try saving it
	# if the model is valid
	# it will be saved
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end