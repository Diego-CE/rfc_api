class Rfc < ApplicationRecord
  attr_accessor :name, :last_name, :second_last_name, :birthdate

  # Presence validations
  validates :name,              presence: true
  validates :last_name,         presence: true
  validates :second_last_name,  presence: true
  validates :birthdate,         presence: true

  # Format Validations
  validates :name, format: { with: /\A[a-zA-Z]+\z/, message: 'only allow letters' }


end
