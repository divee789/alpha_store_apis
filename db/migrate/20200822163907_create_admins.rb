class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_reset_token
      t.string :password_digest
      t.string :image_url
      t.boolean :twofa_enabled, default: false, null: false
      t.string :twofa_secret
      t.timestamps
    end
  end
end
