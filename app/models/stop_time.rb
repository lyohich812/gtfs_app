class StopTime < ApplicationRecord
    has_one :stop
    belongs_to :trip, optional: true

 
end
