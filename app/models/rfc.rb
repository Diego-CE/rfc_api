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

  # Callbacks
  after_initialize :build_key


  def real_date
    unless (Date.parse birthdate rescue false)
      errors.add(:birthdate, 'must be a real date')
    end
  end

  def build_key
    rfc_date = Date.parse birthdate

    self.key = (last_name.remove_accents.first +
      last_name.remove_accents.first_vowel     +
      second_last_name.remove_accents.first    +
      name.remove_accents.first                +
      rfc_date.year.to_s[-2..-1]               +
      rfc_date.month.to_s.rjust(2, "0")        +
      rfc_date.day.to_s.rjust(2, "0")
    ).upcase
  end

end
