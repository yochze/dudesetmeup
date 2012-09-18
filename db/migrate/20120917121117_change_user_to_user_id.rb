class ChangeUserToUserId < ActiveRecord::Migration
  def up
  	remove_column :matches, :user
  	add_column :matches, :user_id, :integer
  end

  def down
  end
end
