class RealtimeJob < ApplicationJob
  queue_as :default
  # RUN_EVERY = 1.hour

  def perform(*args)
    # Perform Job
    require 'json'
    require 'net/http'

    # Parse Data from URL
    url = 'http://portal.gpt.adc.spb.ru/Portal/transport/internalapi/vehicles/positions/?transports=bus,tram,trolley,ship&bbox=29.498291,60.384005,30.932007,59.684381'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data_hash = JSON.parse(response)
    
    # # Do the SAVING and validation HERE...

    data_hash["result"].each do |data|
      new_record = Vehicle.new(data)
      old_record = Vehicle.find_by(vehicleId: new_record.vehicleId)
      if old_record == nil
        new_record.save
      elsif new_record.position != old_record.position
          old_record.update(position: new_record.position)
      end
    end

    # self.class.perform_later(wait: RUN_EVERY)

  end
end
