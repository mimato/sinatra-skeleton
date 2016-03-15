require 'bcrypt'

# API Key storage class, stores password encrypted with bcrypt
class ApiKey < ActiveRecord::Base
  include BCrypt

  belongs_to :user
  validates :user, :name, :identifier, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
