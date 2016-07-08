require 'rails_helper'

RSpec.describe Watchlist, type: :model do
  it "creates a watchlist and destroy" do
    watchlist = Watchlist.create!(user_id: 1, species: "hog", price: "10.30")

    expect(watchlist.species).to eq("hog")
  end

end
