class CreatePetsTable < ActiveRecord::Migration
  def change
    create_table :pets_tables do |t|
      t.belongs_to :seller, index: true #, foreign_key: true
      t.string :price
      t.text :description
      t.string :species
    end
  end
end
