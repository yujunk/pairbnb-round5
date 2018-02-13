class ArticlesController < ApplicationController
		before_action :require_login

	def new
	end

	def index
		current_user.articles 
	end
end
