class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :male
      t.string :female
      t.integer :user

      t.timestamps
    end
  end
end
