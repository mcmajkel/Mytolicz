require 'sinatra' 
require 'haml'
require 'json'

class MyApp < Sinatra::Base
	get '/' do  
	  haml :index  
	end  

	get '/oblicz/:dni' do
		content_type :json
		@dni = params[:dni].to_i
		dni = (((@dni * 8.8 * 2) / 19 * 5.61)*1.1).round.to_json
	end
end