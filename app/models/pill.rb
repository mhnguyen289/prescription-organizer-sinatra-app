class Pill < ActiveRecord::Base
	has_many :prescription_pills
	has_many :prescriptions, through: :prescription_pills

end