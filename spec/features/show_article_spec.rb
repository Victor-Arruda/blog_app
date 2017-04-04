require 'rails_helper'

RSpec.feature "Showing an article" do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create(title: "The first", body: "Lorem ipsum", user: @john)
  end

  scenario "to non-signed user hide the edit and delete buttons" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).to_not have_link("Edit article")
    expect(page).to_not have_link("Delete article")
  end

  scenario "to non-owner user hide the edit and delete buttons" do
    login_as(@fred)
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).to_not have_link("Edit article")
    expect(page).to_not have_link("Delete article")
  end

  scenario "to owner user show the edit and delete buttons" do
    login_as(@john)
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).to have_link("Edit article")
    expect(page).to have_link("Delete article")
  end
end
