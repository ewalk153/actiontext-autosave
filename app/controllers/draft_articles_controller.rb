class DraftArticlesController < ApplicationController
  before_action :set_article
  before_action :set_draft_article, only: %i[ show ]

  def index
  end

  def show
  end

  # POST /draft_articles or /draft_articles.json
  def create
    @draft_article = @article.draft_articles.new(draft_article_params)

    respond_to do |format|
      if @draft_article.save
        format.html { redirect_to article_draft_article_url(@draft_article, article_id: @draft_article.article_id), notice: "Draft article was successfully created." }
        format.json { render :show, status: :created, location: @draft_article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @draft_article.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_draft_article
    @draft_article = DraftArticle.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def draft_article_params
    params.require(:draft_article).permit(:content)
  end
end
