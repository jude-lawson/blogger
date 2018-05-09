require 'rails_helper'

RSpec.describe 'Articles Page' do

  before(:each) do
    @article1 = Article.create!(title: 'Title 1', body: 'Body 1')
    @article2 = Article.create!(title: 'Title 2', body: 'Body 2')

    # Important Page Elements
    @new_article_link_text = "Create A New Article"
  end
  
  describe 'user sees all articles' do
    describe 'they visit /articles' do
      it 'should display all articles' do
        visit '/articles'

        expect(page).to have_link(@article1.title)
        expect(page).to have_link(@article2.title)
      end

      it 'should have a link to create a new article' do
        visit '/articles'

        expect(page).to have_link(@new_article_link_text)
      end
    end
  end
end
