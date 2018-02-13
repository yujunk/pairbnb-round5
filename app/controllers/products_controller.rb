class ProductsController < ApplicationController

	def new
		@product = Product.new 

		render "products/create.html.erb"
	end

	def create
		@product = Product.create(params[product])
	end
end
