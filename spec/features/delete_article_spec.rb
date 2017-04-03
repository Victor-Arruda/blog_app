require 'rails_helper'

RSpec.feature "Deleting an Article" do
  before do
    @article = Article.create(title: "The first", body: "Lorem ipsum")
  end

  scenario "User deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end
