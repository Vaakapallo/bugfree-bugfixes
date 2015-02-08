require 'rails_helper'

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given right values, a beer is created" do
    visit new_beer_path
    fill_in('beer[name]', with:'Honey Porter')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "when given a non-valid name, no beer is not saved" do
  	visit new_beer_path
    select('Koff', from:'beer[brewery_id]')

    click_button "Create Beer"

    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Name can't be blank"

    expect(Beer.count).to eq(0)
  end
end