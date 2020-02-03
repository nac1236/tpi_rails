class Product < ActiveRecord::Base
    validates :code, format: { with: /([a-zA-Z]{3}\d{6})/}, uniqueness: {case_sensitive: true}, presence: true
    validates :description, presence: true, length: { maximum: 200 }
    validates :detail, presence: true
    validates :cost_per_unit, presence: true

    has_many :items
    has_many :details
    has_many :reservation_details
end