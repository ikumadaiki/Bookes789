class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = Book.search_for(@content, @method)
		end
	end

	def get_number_of_post
		user=User.find(params[:user_id])
    date=params[:post_date]
    p date.class
    @post_count=user.books.where(created_at: DateTime.parse(date).all_day).count
	end
end
