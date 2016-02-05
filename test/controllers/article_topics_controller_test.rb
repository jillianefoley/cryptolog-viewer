require 'test_helper'

class ArticleTopicsControllerTest < ActionController::TestCase
  setup do
    @article_topic = article_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_topic" do
    assert_difference('ArticleTopic.count') do
      post :create, article_topic: { name: @article_topic.name, top_words: @article_topic.top_words }
    end

    assert_redirected_to article_topic_path(assigns(:article_topic))
  end

  test "should show article_topic" do
    get :show, id: @article_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article_topic
    assert_response :success
  end

  test "should update article_topic" do
    patch :update, id: @article_topic, article_topic: { name: @article_topic.name, top_words: @article_topic.top_words }
    assert_redirected_to article_topic_path(assigns(:article_topic))
  end

  test "should destroy article_topic" do
    assert_difference('ArticleTopic.count', -1) do
      delete :destroy, id: @article_topic
    end

    assert_redirected_to article_topics_path
  end
end
