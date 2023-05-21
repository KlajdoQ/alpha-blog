class ArticlesController < ApplicationController 
before_action :set_article, only:[:show, :edit, :update, :destroy]
#before_action :require_user, except: [:show, :index] #you have to be logged in to create a new article
# before_action :require_same_user, except: [:edit, :update, :destroy] 
    
    def show
    end
    
    def index 
        @articles = Article.paginate(page: params[:page], per_page: 2)

    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article was successfully created"
            redirect_to @article
        else 
            render "new", status: :unprocessable_entity 
        end
    end

    def edit 
    end

    def update 
        if @article.update(article_params)
            flash[:notice] = "Article has been updated"
            redirect_to @article
        else 
            render "edit"
        end
    end

    def destroy 
        @article.destroy
        redirect_to articles_path
    end

    private

    def set_article
        @article=Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description, :category_ids:[])
    end

    # def require_same_user 
    #     if current_user != @article.user
    #         flash[:alert] = "You can only edit or delete your article"
    #         redirect_to @article
    #     end
    # end
end