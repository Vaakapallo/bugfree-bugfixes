require 'rails_helper'

describe "User page" do
  let(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let(:user1) { FactoryGirl.create :user, username: "Lassi" }
  let(:user2) { FactoryGirl.create :user}

  describe "when ratings exist" do
    before :each do
	  	FactoryGirl.create :rating, beer:beer1, user:user1, score:5 
	  	FactoryGirl.create :rating, beer:beer2, user:user2, score:5

	    visit user_path(user1)
    end

    it "an user can only see their own ratings" do
	    expect(page).to have_content 'Username: Lassi'
	    expect(page).to have_content 'iso 3 5'
	    expect(page).not_to have_content 'Karhu'
  	end

  	it "removing one rating removes it from the database" do
      	sign_in(username:"Pekka", password:"Foobar1")
    	expect{
      		within(".userratings") do
			  click_link("Delete")
			end
    	}.to change{Rating.count}.by(-1)
   	end
  end
end