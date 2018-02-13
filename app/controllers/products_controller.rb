require 'byebug'

class ProductsController < ApplicationController

	def new
		@product = Product.new 

		render "products/create.html.erb"
	end

	def create
		#calls on @product variable in the form and matches key value pair
		#@product = Product.create(params[:product])
		#but this alone is not enough. 
		#by default, rails apps now have 'security' for every attribute on models. You have to permit the attribute you want to access / modify.
		
		@product = Product.new(product_params)
		@product.save
		#passing method "product_params" below

		#This works too, without private method, but will face problems with saving into the database due to nested hashes:
		#@product = Product.new(product_code: params[:product_code], title: params[:title], description: params[:description])
		#@product.save

		#This is the problem:
		#params =
		#<ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"urN+bD3ko6wU2WjCJgsbHRxMc+oIz9dZheIeIIw+XNXWBrJtMShiTiATfrodr7hRliRCCx9ouRS5bn3lc9Y0Ng==", "product"=>{"product_code"=>"970987897", "title"=>"kjahsdjkhasd", "description"=>"akjhsdakjhsda"}, "commit"=>"Create Product", "controller"=>"products", "action"=>"create"} permitted: false>

		#This works to get rid of the hash within the hash issue, but won't cure 'attribute accessor' issue
		#@product = params[:product]
		redirect_to "/"
	end

	private

	def product_params
		params.require(:product).permit(:product_code, :title, :description)
	end
end


#Note: also had legacy issues with changing from postgresql to sqlite3. Had to drop tables and re create/migrate: https://stackoverflow.com/questions/19097558/pg-undefinedtable-error-relation-users-does-not-exist