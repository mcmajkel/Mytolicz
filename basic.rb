require 'sinatra' 
require 'haml'
require 'json'
require 'nokogiri'

class Dane
	@@data = Nokogiri::XML(open('data.xml'))

	def self.cena
		@cena = @@data.xpath('//root/cena').text.to_f
	end

	def self.km
		@km = @@data.xpath('//root/km').text.to_f
	end

	def self.spalanie
		@spalanie = @@data.xpath('//root/spalanie').text.to_f
	end

	def self.amortyzacja
		@amortyzacja = @@data.xpath('//root/amortyzacja').text.to_f
	end
end

class Obliczacz
	def initialize()
		@cenaPaliwa = Dane.cena
		@liczbaKilometrowWJednaStrone = Dane.km
		@amortyzacja = Dane.amortyzacja
		@spalanie = Dane.spalanie
	end
	
	def dni(dni)
		@dni = dni.to_i.abs
	end

	def wynik
		(((@dni * 2 * @liczbaKilometrowWJednaStrone * @spalanie) / 200 * @cenaPaliwa)*@amortyzacja).round
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

	get '/admin' do
		haml :admin
	end

	post '/change' do
		@@oblicz.liczbaKilometrowWJednaStrone(params[:kmwjedna])
		redirect('/')
	end
end