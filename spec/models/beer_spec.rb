require 'rails_helper'

describe Beer do
  it "is not saved without a name" do
    beer = Beer.create

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"5 am Saint"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  describe "with name and style" do
    let(:beer){ Beer.create name:"5 am Saint", style:"Ale" }

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

    def create_beer_with_rating(score, user)
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
    end

end