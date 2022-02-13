require "application_system_test_case"

class DraftArticlesTest < ApplicationSystemTestCase
  setup do
    @draft_article = draft_articles(:one)
  end

  test "visiting the index" do
    visit draft_articles_url
    assert_selector "h1", text: "Draft articles"
  end

  test "should create draft article" do
    visit draft_articles_url
    click_on "New draft article"

    fill_in "Article", with: @draft_article.article_id
    fill_in "Context", with: @draft_article.context
    click_on "Create Draft article"

    assert_text "Draft article was successfully created"
    click_on "Back"
  end

  test "should update Draft article" do
    visit draft_article_url(@draft_article)
    click_on "Edit this draft article", match: :first

    fill_in "Article", with: @draft_article.article_id
    fill_in "Context", with: @draft_article.context
    click_on "Update Draft article"

    assert_text "Draft article was successfully updated"
    click_on "Back"
  end

  test "should destroy Draft article" do
    visit draft_article_url(@draft_article)
    click_on "Destroy this draft article", match: :first

    assert_text "Draft article was successfully destroyed"
  end
end
