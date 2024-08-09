class CreatePictureUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :picture_users do |t|
      t.references :picture, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :like
      t.boolean :dislike

      t.timestamps
    end
  end
end
