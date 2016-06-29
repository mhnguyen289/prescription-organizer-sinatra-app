class Prescription < ActiveRecord::Base
	belongs_to :user
  has_many :prescription_pills
  has_many :pills, through: :prescription_pills
end