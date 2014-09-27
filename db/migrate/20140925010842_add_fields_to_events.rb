class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :image_file_name, :string
    add_column :events, :capacity, :integer
  end
end
