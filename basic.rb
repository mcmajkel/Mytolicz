require 'sinatra' 
require 'haml'
require 'json'

set :haml, :format => :html5

get '/' do  
  haml :index  
end  

get '/oblicz/:dni' do
	content_type :json
	@dni = params[:dni].to_i
	dni = (((@dni * 8.8 * 2) / 19 * 5.61)*1.1).round.to_json
end

get '/form' do  
  haml :form  
end  

post '/form' do
  "You said #{params[:message]}"
end