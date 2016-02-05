class ArticleTopicsController < ApplicationController
  before_action :set_article_topic, only: [:show, :edit, :update, :destroy]

  # GET /article_topics
  # GET /article_topics.json
  def index
    @article_topics = ArticleTopic.all
  end

  # GET /article_topics/1
  # GET /article_topics/1.json
  def show
  end

  # GET /article_topics/new
  def new
    @article_topic = ArticleTopic.new
  end

  # GET /article_topics/1/edit
  def edit
  end

  # POST /article_topics
  # POST /article_topics.json
  def create
    @article_topic = ArticleTopic.new(article_topic_params)

    respond_to do |format|
      if @article_topic.save
        format.html { redirect_to @article_topic, notice: 'Article topic was successfully created.' }
        format.json { render :show, status: :created, location: @article_topic }
      else
        format.html { render :new }
        format.json { render json: @article_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_topics/1
  # PATCH/PUT /article_topics/1.json
  def update
    respond_to do |format|
      if @article_topic.update(article_topic_params)
        format.html { redirect_to @article_topic, notice: 'Article topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @article_topic }
      else
        format.html { render :edit }
        format.json { render json: @article_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_topics/1
  # DELETE /article_topics/1.json
  def destroy
    @article_topic.destroy
    respond_to do |format|
      format.html { redirect_to article_topics_url, notice: 'Article topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_topic
      @article_topic = ArticleTopic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_topic_params
      params.require(:article_topic).permit(:name, :top_words)
    end
end
