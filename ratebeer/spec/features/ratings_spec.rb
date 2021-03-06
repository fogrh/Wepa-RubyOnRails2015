require 'rails_helper'

include OwnTestHelper

describe "Ratings page" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:rated) { FactoryGirl.create :rating2, beer:beer2, user:user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.by(1)

    expect(user.ratings.count).to eq(2)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
	it "ratings are shown in the page" do
	
	visit ratings_path
	expect(page).to have_content "Number of ratings: #{Rating.count}"
  	Rating.all.each do |r|
     	 expect(page).to have_content r
	expect(page).to have_content r.user.username
    end
	end
end
