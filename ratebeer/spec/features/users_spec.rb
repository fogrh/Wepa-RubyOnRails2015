require 'rails_helper'

include OwnTestHelper

describe "Users page" do
 
  before :each do
    FactoryGirl.create :user
  end

  describe "User who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end
   describe "User ratings" do
	
	it "are shown in the user's own page" do
	us = User.find_by username:"Pekka"
	beer = FactoryGirl.create(:beer)
	rating = us.ratings.new score:20, beer_id:beer.id
	rating2 = us.ratings.new score:10, beer_id:beer.id
	rating.save 
	rating2.save
	visit user_path(us)
	 us.ratings.each do |r|
	   expect(page).to have_content "#{r.beer.name} | #{r.score}"
	  end
	 end

	it "and deleted ratings is removed from the database" do
	sign_in(username:"Pekka", password:"Foobar1")
	us = User.find_by username:"Pekka"
	beer = FactoryGirl.create(:beer)
	rating = us.ratings.new score:20, beer_id:beer.id
	rating2 = us.ratings.new score:10, beer_id:beer.id
	rating.save 
	rating2.save
	visit user_path(us)
	
	 us.ratings.each do |r|
	page.find('tr', :text => "#{r.beer.name} | #{r.score}").click_link('Delete')
	  end
	expect(us.ratings.count).to eq(0)
	end 
   end

end
