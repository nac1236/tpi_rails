class User < ApplicationRecord
    validates :username, uniqueness: {case_sensitive: true}, presence: true
    validates :password, presence: true
    
    has_many :sells
end
