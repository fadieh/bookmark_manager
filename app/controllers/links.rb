post '/links' do
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
	Tag.first_or_create(:text => tag)
end
	Link.create(:url => url, :title => title, :tags => tags)
	redirect to('/')
end

get '/upvote/:id' do
	link = Link.first(:id => params[:id])
	link.upvote
	redirect '/'
end

get '/downvote/:id' do
	link = Link.first(:id => params[:id])
	link.downvote
	redirect '/'
end

get '/delete/:id' do
	link = Link.first(:id => params[:id])
	link.delete
	redirect '/'
end