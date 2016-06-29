class CreatePills < ActiveRecord::Migration
  def change
  	create_table :pills do |t|
  		t.string :name
  		t.string :instruction
  		t.integer :exp_date
  		
  	end
  end
end
