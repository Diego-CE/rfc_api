require 'rails_helper'

RSpec.describe Rfc, type: :model do

  rfc_valid_attributes = {name: 'Nancy', last_name: 'Chávez',
    second_last_name: 'Vázquez', birthdate: '1990-05-29'}

  context "attributes validations" do

    it "have valid attributes" do
      rfc = Rfc.new(rfc_valid_attributes)
      expect(rfc).to be_valid
    end

    it "have not name" do
      rfc = Rfc.new(rfc_valid_attributes)
      rfc.name = ""
      expect(rfc).to_not be_valid
    end

    it "have a invalid name" do
      rfc = Rfc.new(rfc_valid_attributes)
      rfc.name = "N4ncy*"
      expect(rfc).to_not be_valid
    end

    it "have not last_name" do
      rfc = Rfc.new(rfc_valid_attributes)
      rfc.last_name = ""
      expect(rfc).to_not be_valid
    end

    it "have an invalid last_name" do
      rfc = Rfc.new(rfc_valid_attributes)
      rfc.last_name = "Cháv3z*"
      expect(rfc).to_not be_valid
    end

    it "have not second_last_name" do
      rfc = Rfc.new(rfc_valid_attributes)
      rfc.second_last_name = ""
      expect(rfc).to be_valid
    end

    it "have an invalid last_name" do
      rfc = Rfc.new(rfc_valid_attributes)
      rfc.second_last_name = "Vázqu3z*"
      expect(rfc).to_not be_valid
    end

    it "have not birthdate" do
      rfc = Rfc.new(rfc_valid_attributes)
      rfc.birthdate = ""
      expect(rfc).to_not be_valid
    end

    it "have an invalid date" do
      rfc = Rfc.new(rfc_valid_attributes)
      rfc.birthdate = "1990-05-32"
      expect(rfc).to_not be_valid
    end

    it "have an invalid date format" do
      rfc = Rfc.new(rfc_valid_attributes)
      rfc.birthdate = "1990/05/29"
      expect(rfc).to_not be_valid
    end
  end

  it "build a valid key" do
    rfc = Rfc.new(rfc_valid_attributes)
    expect(rfc).to have_attributes(key: 'CAVN900529')
  end

  it "build a valid key without second last name" do
    rfc = Rfc.new(name: 'Nancy', last_name: 'Chávez', birthdate: '1990-05-29')
    expect(rfc).to have_attributes(key: 'CAXN900529')
  end

  it "count was increased" do
    Rfc.create(rfc_valid_attributes)
    rfc = Rfc.create_if_not_exists(rfc_valid_attributes)

    expect(rfc.count).to eq 2
  end

end
