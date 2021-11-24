class Rfc < ApplicationRecord
  attr_accessor :name, :last_name, :second_last_name, :birthdate

  # Presence validations
  validates :name,              presence: true
  validates :last_name,         presence: true
  validates :second_last_name,  presence: true
  validates :birthdate,         presence: true

  # Format Validations
  validates :name,              format: { with: /\A[\p{L}\p{M}]+\z/, message: 'only allow letters' }
  validates :last_name,         format: { with: /\A[\p{L}\p{M}]+\z/, message: 'only allow letters' }
  validates :second_last_name,  format: { with: /\A[\p{L}\p{M}]+\z/, message: 'only allow letters' }

  # Custom validations
  validate :real_date

  def real_date
    unless (Date.parse birthdate rescue false)
      errors.add(:birthdate, 'must be a real date')
    end
  end

end
