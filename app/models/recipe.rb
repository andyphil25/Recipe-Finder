class Recipe < ActiveRecord::Base

	include HTTParty

	default_options.update(verify: false)

	key_value	=	ENV['FOOD2FORK_KEY']
	base_uri	"http://www.food2fork.com/api"
	default_params key: key_value 
	format :json

	def self.search term
		Recipe.where("title LIKE :search OR ingredients LIKE :search", search: "%#{term}%")
	end
	
	def self.for term
		get("/search", query: {q:term})["recipes"]
	end

	def self.get_ingredients recipe_id
		get("/get", query: {rId: recipe_id })["recipe"]["ingredients"]
	end
end
