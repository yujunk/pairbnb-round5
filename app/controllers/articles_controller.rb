class ArticlesController < ApplicationController
		before_action :require_login

	def new
	end

end

#This page is not necessary
#@before_action - is for special login needs
