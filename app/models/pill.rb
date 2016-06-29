class Pill < ActiveRecord::Base
	has_many :prescription_pills
	has_many :prescriptions, through: :prescription_pills

	def self.valid_params?(params)
    return !params[:name].empty? && !params[:manufacturer].empty?
  end

  def self.not_linked_to(prescription_id)
    prescription = Prescription.find(prescription_id)
    pills = []
    Pill.all.each do |pill|
      if !prescription.pill_ids.include?(pill.id)
        pills << pill
      end
    end
    pills
  end
end