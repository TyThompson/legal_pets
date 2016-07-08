require 'rails_helper'

RSpec.describe Pet, type: :model do
  it "creates a pet db item" do
    pet = Pet.create!(seller_id: 1, species: "hog", common_name: "hog", price: "10.30", description: "eats a lot", status: "available", image_url: "www.imageurl.com/image.jpg")

    expect(pet.species).to eq("hog")
  end


end
