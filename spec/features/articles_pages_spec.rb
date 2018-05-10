require 'rails_helper'

RSpec.describe 'Articles Page' do

  before(:each) do
    @article1 = Article.create!(title: 'Title 1', body: 'Body 1')
    @article2 = Article.create!(title: 'Title 2', body: 'Body 2')

    # Important Page Elements
    @new_article_link_text = "Create A New Article"
  end
  
  context 'they visit /articles' do
    describe 'user sees all articles'do
      it 'should display all articles' do
        visit articles_path

        expect(page).to have_link(@article1.title)
        expect(page).to have_link(@article2.title)
      end

      it 'should have a link to create a new article' do
        visit articles_path

        expect(page).to have_link(@new_article_link_text)
      end
    end
  end

  context '/articles/show page' do
    describe 'user clicks on article link on articles page' do
      it 'they see a specific articles page' do
        visit articles_path

        click_link(@article1.title)

        expect(current_path).to eq("/articles/#{@article1.id}")
      end

      it 'they should see the information for that article' do
        visit articles_path

        click_link(@article1.title)

        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page).to_not have_content(@article2.body)
        expect(page).to_not have_content(@article2.body)
      end
    end
  end
end
