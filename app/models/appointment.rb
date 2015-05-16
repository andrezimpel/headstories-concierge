class Appointment < ActiveRecord::Base

  # associations
  belongs_to :client
end
