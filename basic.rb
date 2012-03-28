require 'sinatra' 
require 'haml'
require 'json'

class Obliczacz
	def initialize(dni, cenaPaliwa = 5.61, liczbaKilometrowWJednaStrone=8.8, amortyzacja=1.1)
		@cenaPaliwa = cenaPaliwa
		@liczbaKilometrowWJednaStrone = liczbaKilometrowWJednaStrone
		@amortyzacja = amortyzacja
		@dni = dni
	end
	attr_accessor :cenaPaliwa, :wynik, :dni, :liczbaKilometrowWJednaStrone, :amortyzacja 

	def wynik
		return (((dni * liczbaKilometrowWJednaStrone * 2) / 19 * cenaPaliwa)*amortyzacja).round
	end
end

class MyApp < Sinatra::Base
	get '/' do  
	  haml :index  
	end  

	get '/oblicz/:dni' do
		oblicz = Obliczacz.new(params[:dni].to_i)
		content_type :json
		oblicz.wynik.to_json
	end
end