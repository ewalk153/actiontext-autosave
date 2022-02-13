class DraftArticlesController < ApplicationController
  before_action :set_article
  before_action :set_draft_article, only: %i[ show edit update destroy ]

  # GET /draft_articles or /draft_articles.json
  def index
    @draft_articles = DraftArticle.all
  end

  # GET /draft_articles/1 or /draft_articles/1.json
  def show
  end

  # GET /draft_articles/new
  def new
    @draft_article = DraftArticle.new
  end

  # GET /draft_articles/1/edit
  def edit
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

  # PATCH/PUT /draft_articles/1 or /draft_articles/1.json
  def update
    respond_to do |format|
      if @draft_article.update(draft_article_params)
        format.html { redirect_to draft_article_url(@draft_article), notice: "Draft article was successfully updated." }
        format.json { render :show, status: :ok, location: @draft_article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @draft_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /draft_articles/1 or /draft_articles/1.json
  def destroy
    @draft_article.destroy

    respond_to do |format|
      format.html { redirect_to draft_articles_url, notice: "Draft article was successfully destroyed." }
      format.json { head :no_content }
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
