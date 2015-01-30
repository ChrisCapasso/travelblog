class CreateRelationshipsTable < ActiveRecord::Migration
  def change
  	create_table :relationships do |t|
  		t.integer :follower_id
  		t.integer :folowed_id
  	end
  end
end
