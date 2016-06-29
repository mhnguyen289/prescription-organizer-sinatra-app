class CreatePrescriptionPills < ActiveRecord::Migration
  def change
  	create_table :prescription_pills do |t|
  		t.integer :prescription_id
  		t.integer :pill_id
  	end
  end
end
