class AddLablesToPictures < ActiveRecord::Migration[7.1]
  def change
    add_column :pictures, :labels, :string
  end
end
