require 'rails_helper'

describe "Ratings page" do
  let(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let(:user) { FactoryGirl.create :user }
  let(:rating) {FactoryGirl.create :rating, beer:beer1, user:user, score:5 }

  it "should not have any before been created" do
    visit ratings_path
    expect(page).to have_content 'Listing Ratings'
    expect(page).to have_content 'Total of 0 ratings.'
  end

  describe "when ratings exist" do
    before :each do
  	  FactoryGirl.create :rating, beer:beer1, user:user, score:5 
      visit ratings_path
    end

    it "lists the total number of ratings" do
      expect(page).to have_content "Total of 1 ratings."
    end
  end
end