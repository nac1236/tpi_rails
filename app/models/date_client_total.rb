class DateClientTotal
    include ActiveModel::Conversion
    attr_accessor :date, :client, :total

    def initialize(date, client, total)
        @date = date
        @client = client
        @total = total
    end

    def persisted?
      false
    end
  
    def id
      nil
    end
end