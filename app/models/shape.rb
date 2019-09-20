class Shape < ApplicationRecord
    has_and_belongs_to_many :trip, optional: true
    
end
