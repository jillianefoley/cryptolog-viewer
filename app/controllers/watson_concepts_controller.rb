class WatsonConceptsController < ApplicationController
  before_action :set_concept, only: [:show]

  def index
    @header = "Concepts"
    @concepts = WatsonConcept.all.joins('join articles_watson_concepts a on a.watson_concept_id = watson_concepts.id').group('watson_concept_id').order('count(`a`.`article_id`) desc')
  end

  def show
    @header = "\"#{@concept.name}\""
    @article_search = Article.search(:include => [:issue, :person]) do
      with(:concept_ids, params[:id])
      order_by :page, :asc
      paginate :page => params[:page], :per_page => 30
    end
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concept
      @concept = WatsonConcept.find(params[:id])
    end
end
