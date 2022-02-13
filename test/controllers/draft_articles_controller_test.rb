require "test_helper"

class DraftArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @draft_article = draft_articles(:one)
  end

  test "should get index" do
    get draft_articles_url
    assert_response :success
  end

  test "should get new" do
    get new_draft_article_url
    assert_response :success
  end

  test "should create draft_article" do
    assert_difference("DraftArticle.count") do
      post draft_articles_url, params: { draft_article: { article_id: @draft_article.article_id, context: @draft_article.context } }
    end

    assert_redirected_to draft_article_url(DraftArticle.last)
  end

  test "should show draft_article" do
    get draft_article_url(@draft_article)
    assert_response :success
  end

  test "should get edit" do
    get edit_draft_article_url(@draft_article)
    assert_response :success
  end

  test "should update draft_article" do
    patch draft_article_url(@draft_article), params: { draft_article: { article_id: @draft_article.article_id, context: @draft_article.context } }
    assert_redirected_to draft_article_url(@draft_article)
  end

  test "should destroy draft_article" do
    assert_difference("DraftArticle.count", -1) do
      delete draft_article_url(@draft_article)
    end

    assert_redirected_to draft_articles_url
  end
end
