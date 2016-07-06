class Pet < ActiveRecord::Base
  belongs_to :seller, class_name: "User"
  validates_presence_of :species, :description, :price


  def accessible_attributes
    ["Species", "Set Price", "Description"]
  end

  def self.import(file, user)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      pet = find_by_id(row["id"]) || new
      pet.attributes = row.to_hash.slice(*row.to_hash.keys)
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
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |pet|
        csv << pet.attributes.values_at(*column_names)
      end
    end
  end
end
