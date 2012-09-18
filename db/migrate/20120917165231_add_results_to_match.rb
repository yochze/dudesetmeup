class AddResultsToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :result, :boolean
  end
end
