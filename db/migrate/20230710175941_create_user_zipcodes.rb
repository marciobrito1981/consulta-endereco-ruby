class CreateUserZipcodes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_zipcodes do |t|
      t.string :userid
      t.string :userEmail
      t.string :zipcode

      t.timestamps
    end
  end
end
