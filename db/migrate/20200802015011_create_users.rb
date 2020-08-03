class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :email_verification_token
      t.string :phone_number_verification_token
      t.string :phone_number
      t.string :password_reset_token
      t.string :password_digest
      t.string :image_url
      t.boolean :twofa_enabled
      t.string :twofa_secret
      t.timestamps
    end
  end
end
