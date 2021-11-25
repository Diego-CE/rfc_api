require 'rails_helper'

RSpec.describe "RFC Controller", type: :request do
  describe "GET /new" do

    let :req_params do
      {
        "name": "Nancy",
        "last_name": "Chávez",
        "second_last_name": "Vázquez",
        "birthdate": "1990-05-29"
      }
    end

    it "build new RFC key" do
      get new_rfc_path, params: req_params
      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json).to eq({
          rfc: "CAVN900529",
          count: 1
        })
    end
  end
end
