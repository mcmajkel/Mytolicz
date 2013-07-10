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

	def self.liczba_osob
		@liczba_osob = @@data.xpath('//root/liczba_osob').text.to_i
	end

	def self.powrot?
		@@data.xpath('//root/powrot').text.to_i == 1 ? true : false
	end
end

class Obliczacz

	def initialize()
		@cenaPaliwa = Dane.cena
		@liczbaKilometrowWJednaStrone = Dane.km
		@spalanie = Dane.spalanie
		@powrot = Dane.powrot? ? 2 : 1
		@liczba_osob = Dane.liczba_osob
<<<<<<< HEAD
=======
	end

	def assign(params)
		@cenaPaliwa = params[:cena].to_f
		@dni = params[:dni].to_i
		@liczbaKilometrowWJednaStrone = params[:km].to_f
		@liczba_osob = params[:osob].to_i
		@powrot = params[:powrot] == "true" ? 2 : 1
	end
	
	def dni(dni)
		@dni = dni.to_i.abs
>>>>>>> 0f9f5889e6e58b06bd7a94c0619999e5889f9a74
	end

	def assign(params)
		@cenaPaliwa = params[:cena].to_f
		@dni = params[:dni].to_i
		@liczbaKilometrowWJednaStrone = params[:km].to_f
		@liczba_osob = params[:osob].to_i
		@powrot = params[:powrot] == "true" ? 2 : 1
	end
	
	def wynik
		spalanie_na_odcinku = (@spalanie * @liczbaKilometrowWJednaStrone) / 100
		koszt = @dni * spalanie_na_odcinku * @cenaPaliwa * @powrot/ @liczba_osob
	end
end

class MyApp < Sinatra::Base

	#klasa tworzona raz, dostepna dla calej aplikacji
	@@oblicz = Obliczacz.new()

	get '/' do  
	  	haml :index  
	end  

	get '/oblicz/:dni/:cena/:km/:osob/:powrot' do
		@@oblicz.assign params
		content_type :json
		@@oblicz.wynik.round.to_json
	end
end