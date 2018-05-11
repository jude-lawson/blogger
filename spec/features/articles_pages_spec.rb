require 'rails_helper'

RSpec.describe 'Articles Page' do

  before(:each) do
    @article1 = Article.create!(title: 'Title 1', body: 'Body 1')
    @article2 = Article.create!(title: 'Title 2', body: 'Body 2')

    # Important Page Elements
    @new_article_link_text = "Create A New Article"
  end
  
  context 'showing all aticles' do
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

  context 'showing an article' do
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

  context 'creating a new article' do
    describe 'user creates a new article' do
      describe 'they link from the article index' do
        describe 'they fill in a title and body' do
          it 'creates a new article' do
            visit articles_path

            click_link "Create A New Article"

            expect(current_path).to eq(new_article_path)
            new_title = "New Title!"
            new_body = "New Body!"

            fill_in "article[title]", with: new_title
            fill_in "article[body]", with: new_body
            click_on "Create Article"

            expect(page).to have_content("'#{new_title}' has been created")
            # expect(current_path).to eq("/article/#{}")
            expect(page).to have_content(new_title)
            expect(page).to have_content(new_body)
          end
        end
      end
    end
  end

  context 'deleting an article' do
    describe 'user deletes an article' do
      describe 'they link from the show page' do
        it 'displays all articles without the deleted entry' do
          
          visit article_path(@article1)

          click_link "Delete"

          expect(page).to have_content("Article '#{@article1.title}' has been deleted")
          expect(current_path).to eq(articles_path)
          expect(page).to have_content(@article2.title)
          within('#articles') do
            expect(page).to_not have_content(@article1.title)
          end
        end
      end
    end
  end

  context 'editing an article' do
    describe 'a user edits an article' do
      describe 'they click the edit link on the show article page' do
        it 'they should be able to submit edits and view the update article' do
        
          visit article_path(@article1)

          click_link 'Edit'
          edited_title = 'A New Title'
          edited_body = 'This is a new article body.'

          expect(current_path).to eq(edit_article_path(@article1))
          fill_in 'article[title]', with: edited_title
          fill_in 'article[body]', with: edited_body
          click_button('Update Article')

          expect(page).to have_content("Article #{edited_title} was updated.")
          expect(current_path).to eq(article_path(@article1))
          expect(page).to have_content(edited_title)
          expect(page).to have_content(edited_body)
        end
      end
    end
  end
end
