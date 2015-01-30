class CreateUsersTable < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :fname
  		t.string :lname
  		t.string :email
  		t.string :password
  		t.string :location
  		t.string :about
  		t.timestamps
  	end
  end
end