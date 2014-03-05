class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :encrypted_password
      t.string :authentication_token
      t.timestamps
    end

    add_index :users, :username,                :unique => true
    add_index :users, :authentication_token
  end
end
