class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_hash
      t.string :bio
      t.references :playlist
      t.timestamps null: false
    end
  end
end
