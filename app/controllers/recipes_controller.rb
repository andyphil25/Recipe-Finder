class RecipesController < ApplicationController

  before_action :set_recipe, only: [:show]

  def index
  	if params[:search]
  		@search_term = params[:search] 
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
  	puts params[:search]
  end

  private

  	def set_recipe
  		@recipe  = Recipe.find(params[:id])

  	end

end
