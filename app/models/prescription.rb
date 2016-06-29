class Prescription < ActiveRecord::Base
	belongs_to :user
  has_many :prescription_pills
  has_many :pills, through: :prescription_pills

  def self.valid_params?(params)
    return !params[:name].empty? && !params[:capacity].empty?
  end

  def become_active
    Prescription.all.each do |prescription|
      prescription.active = false
      prescription.save
    end
    self.active = true
    self.save
  end
end