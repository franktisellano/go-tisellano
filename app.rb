require 'sinatra'
require './link'

get '/' do
	start = Time.now

	@links = Link.all

	the_end = Time.now
	puts "Retrieved in #{the_end - start} seconds."

	erb :index
end

get '/new' do
	erb :new
end

post '/new' do
	n = params[:name]
	u = params[:url]

	if n.empty? || u.empty?
		@message = "Fill out both."
		halt erb :new
	end
	
	if n == 'new'
		@message = "Invalid name."
		halt erb :new
	end
	
	if Link.find(n) != false
		@message = "Already exists."
		halt erb :new
	end
	
	Link.new(n, u).save
	redirect to('/')

end

get '/:slug' do
	start = Time.now

	link = Link.find(params[:slug])

	the_end = Time.now
	puts "Retrieved in #{the_end - start} seconds."

	if link
		redirect to(link.url)
	else
		redirect to('/')
	end
end