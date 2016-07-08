class Pet < ActiveRecord::Base
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"
  validates_presence_of :species, :description, :price

  def self.import(file, user)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      pet = find_by_id(row["id"]) || new
      pet.attributes = row.to_hash.slice(*row.to_hash.keys)
      pet.image_url = get_pic(pet.species, pet.common_name)
      pet.seller_id = user.id
      pet.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.to_csv(options = {})
    wanted_columns = ["id", "seller_id", "species", "common_name", "price", "description", "status", "buyer_id"]
    CSV.generate(options) do |csv|
      csv << wanted_columns
      all.each do |pet|
        csv << pet.attributes.values_at(*wanted_columns)
      end
    end
  end

  def self.get_pic(species, common_name)
    species_resp = HTTParty.get("https://pixabay.com/api/",
    query: {:key => ENV["PIXABAY_KEY"],
            :q => species,
            :image_type => 'photo'})

    common_resp = HTTParty.get("https://pixabay.com/api/",
    query: {:key => ENV["PIXABAY_KEY"],
            :q => common_name,
            :image_type => 'photo'})

    if species_resp["hits"].present?
      species_resp["hits"].first["webformatURL"]
    elsif common_resp["hits"].present?
      common_resp["hits"].first["webformatURL"]
    else
      '/No_Image_Available.png'
    end
  end

  def get_pic
    species_resp = HTTParty.get("https://pixabay.com/api/",
    query: {:key => ENV["PIXABAY_KEY"],
            :q => self.species,
            :image_type => 'photo'})

    common_resp = HTTParty.get("https://pixabay.com/api/",
    query: {:key => ENV["PIXABAY_KEY"],
            :q => self.common_name,
            :image_type => 'photo'})

    if species_resp["hits"].present?
      self.image_url = species_resp["hits"].first["webformatURL"]
    elsif common_resp["hits"].present?
      self.image_url = common_resp["hits"].first["webformatURL"]
    else
      self.image_url = '/No_Image_Available.png'
    end
  end
end
