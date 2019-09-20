class ImportService

    require 'csv'

    # def self.initialize
        
    # end

    def self.import(filename, classname)
        CSV.foreach(filename, :headers => true) do |row|
            "#{classname}".constantize.create!(row.to_hash)
        end
    end

    

    
end    