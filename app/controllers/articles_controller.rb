class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @header = 'Articles'

    @article_search = Article.search(:include => [:issue, :person]) do
      keywords params[:q] do
        highlight :text
      end
      order_by :year unless params[:q]
      order_by :month unless params[:q]
      paginate :page => params[:page], :per_page => 30
    end
  end

  # POST /search
  def search

  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @header = @article.title
    @same_author = Article.where(:author_id => @article.author_id).where.not(:id => @article.id) if @article.author_id
    @concepts = @article.watson_concepts
  end

  # GET /articles/new
  def new
    @article = Article.new
    @header = 'New Article'
  end

  # GET /articles/1/edit
  def edit
    @header = @article.title
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(params[:type].to_sym).permit(:title, :type, :puzzle_type, :text, :redactions, :picture, :redacted, :page)
    end
end
