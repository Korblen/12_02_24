class User < ApplicationRecord
    belongs_to :city, optional: true
    has_many :gossips
    has_many :comments
    has_secure_password
end
