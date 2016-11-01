class RecipesController < ApplicationController

  before_action :set_recipe, only: [:show]
  before_action :sample_recipes, only: [:index, :show]

  def index
  	
  	if params[:search] and not params[:search].empty? and not params[:search].blank?
  		if params[:search].match('[0-9;\.]')
  			flash[:error] = "INVALID search input"
  			return
  		end
  		
  		@search_term = params[:search].strip
  		search_records = Recipe.search @search_term
	    
	    if search_records.empty?
	    	new_recipes = Recipe.for(@search_term)
	    	new_records = []
		  	new_recipes.each do |recipe|
		  		db_param = { :recipeId => recipe['recipe_id'], :title => recipe['title'],
		  			:source_url => recipe['source_url'], :image_url => recipe['image_url'],
		  			:ingredients => Recipe.get_ingredients(recipe['recipe_id']).join(';')}
		  		new_records << db_param
		  	end
		  	@recipes = Recipe.create new_records
		  	puts "Record new"
		  	puts @recipes
	    else
	    	puts "Record existed"
	    	@recipes = search_records
	    	puts @recipes
	    end
  	else
  		puts "no search"
  	end
  end

  def show
  end

  private

  	def set_recipe
  		@recipe  = Recipe.find(params[:id])
  	end
		
		def sample_recipes
	  	#@samples = Recipe.take 5
	  	recipes_count = Recipe.count
			@samples = Recipe.limit(5).offset(rand(recipes_count))
	  end
end
