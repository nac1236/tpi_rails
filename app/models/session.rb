class Session
    include ActiveModel::Conversion
    attr_accessor :token

    def initialize(token)
        @token = token
    end

    def persisted?
      false
    end
  
    def id
      nil
    end
end