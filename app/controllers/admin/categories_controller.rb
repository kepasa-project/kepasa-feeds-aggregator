module Admin
	class CategoriesController < AdminBaseController

		layout "admin"
		
		before_action :authenticate_user!

		before_action :set_category, only: [:show, :edit, :destroy, :update]

		def index

			current_language = Category.current_language
			@categories = Category.all.where(language: current_language)
			@language = current_language
			
		end

		def new
			@category = Category.new
		end

		def show

			@recommended_feeds = @category.recommended_feeds

		end

		def create

			@category = Category.new(category_params)

			if @category.save
				redirect_to admin_categories_path
			else
				render :new
			end

		end

		def edit

		end

		def update

			respond_to do |format|
				if @category.update(category_params)
					format.html { redirect_to admin_categories_path, notice: 'Category was successfully updated.'}
	        		format.json { head :no_content }
	      		else
	        		format.html { render action: "edit" }
	        		format.json { render json: @category.errors, status: :unprocessable_entity }
	      		end
			end
		
		end

		private

		def category_params
		  	params.require(:category).permit(:name, :language, :category_logo)
		end

		def set_category
			@category = Category.find(params[:id])
		end

	end
end