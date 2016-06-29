class PrescriptionPill < ActiveRecord::Base
	belongs_to :prescription
	belongs_to :pill
end