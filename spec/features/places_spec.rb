require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple are returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Kurjenolsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Kurjenolsi"

  end

  it "if none are returned by the API, a notice is shown" do
    canned_answer = <<-END_OF_STRING
		<?xml version='1.0' encoding='utf-8' ?>
		<bmp_locations>
		<location>
		<id/>
		<name/>
		<status/>
		<reviewlink/>
		<proxylink/>
		<blogmap/>
		<street/>
		<city/>
		<state/>
		<zip/>
		<country/>
		<phone/>
		<overall/>
		<imagecount/>
		</location>
		</bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*exactum/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    visit places_path
    fill_in('city', with: 'exactum')
    click_button "Search"

    expect(page).to have_content "No locations in exactum"
  end
end