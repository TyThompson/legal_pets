class Pet < ActiveRecord::Base
  belongs_to :seller, class_name: "User"
  validates_presence_of :species, :description, :price
  
end
