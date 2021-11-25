class Rfc < ApplicationRecord
  attr_accessor :name, :last_name, :second_last_name, :birthdate

  # Presence validations
  validates :name,              presence: true
  validates :last_name,         presence: true
  validates :birthdate,         presence: true

  # Format Validations
  validates :name,              format: { with: /\A[\p{L}\p{M}]+\z/, message: 'only allow letters' }
  validates :last_name,         format: { with: /\A[\p{L}\p{M}]+\z/, message: 'only allow letters' }
  validates :second_last_name,  format: { with: /\A[\p{L}\p{M}]+\z/, message: 'only allow letters' }, allow_blank: true

  # Custom validations
  validate :real_date, on: :create

  # Callbacks
  after_initialize :build_key

  # REAL DATE
  #
  # Custom validation for real date
  #
  # @example
  #
  # 1990-05-32 is an unreal date, so can't be create a key
  def real_date
    unless (Date.parse birthdate rescue false)
      errors.add(:birthdate, 'must be a real date')
    end
  end

  # BUILD KEY
  #
  # Method for build de key.
  # Uses the params now as attributes to build the key following the business rules
  #
  # +First 2 chars+ Came from the first char and first vowel of last name
  #
  # +Third char+ Came from the first char of second last name, if doesn't have a second last name then uses X
  #
  # +Fourth char+ Came from the first char of name
  #
  # +Fifth and sixth chars+ Came from the last 2 digits of the birth year
  #
  # +Seventh char+ Came from birth month in 2 digits format ( january = 01 )
  #
  # +Eighth char+ Came from birth day in 2 digits format ( 1st = 01 )
  def build_key
    rfc_date = Date.parse birthdate rescue nil

    self.key ||= (last_name.remove_accents.first            +
      last_name.remove_accents.first_vowel                  +
      (second_last_name.remove_accents.first rescue 'X')    +
      name.remove_accents.first                             +
      rfc_date.year.to_s[-2..-1]                            +
      rfc_date.month.to_s.rjust(2, "0")                     +
      rfc_date.day.to_s.rjust(2, "0")
    ).upcase rescue nil
  end


  # CREATE OR UPDATE
  #
  # Custom method for handle the increase count when the key was asked before.
  def self.create_if_not_exists(attr = {})
    new_rfc = Rfc.new(attr)
    rfc = Rfc.find_by_key(new_rfc.key)
    if rfc.present?
      rfc.update(count: rfc.count + 1)
      return rfc
    else
      new_rfc.save
      return new_rfc
    end
  end

end
