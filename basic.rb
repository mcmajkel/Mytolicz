require 'sinatra' 
require 'haml'
require 'json'

class Obliczacz
	def initialize(cenaPaliwa = 5.61, liczbaKilometrowWJednaStrone=8.8, amortyzacja=1.1, spalanie=10)
		@cenaPaliwa = cenaPaliwa
		@liczbaKilometrowWJednaStrone = liczbaKilometrowWJednaStrone
		@amortyzacja = amortyzacja
		@spalanie = spalanie
	end
	
	def dni(dni)
		@dni = dni.to_i.abs
	end

	def wynik
		return (((@dni * 2 * @liczbaKilometrowWJednaStrone * @spalanie) / 200 * @cenaPaliwa)*@amortyzacja).round
	end
end

class MyApp < Sinatra::Base

	#klasa tworzona raz, dostepna dla calej aplikacji
	@@oblicz = Obliczacz.new()

	get '/' do  
	  haml :index  
	end  

	get '/oblicz/:dni' do
		@@oblicz.dni(params[:dni])
		content_type :json
		@@oblicz.wynik.to_json
	end
end