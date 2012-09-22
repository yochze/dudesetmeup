class ChangeFemaleAndNameToTextType < ActiveRecord::Migration
  def up
  	change_column :matches, :male, :text, :limit => nil
  	change_column :matches, :female, :text, :limit => nil
  end

  def down
  end
end
