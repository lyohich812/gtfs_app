class Trip < ApplicationRecord
    has_many :stoptimes
    has_and_belongs_to_many :shapes, optional: true
    belongs_to :route, optional: true
  
end
