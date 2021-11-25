class RfcController < ApplicationController

  # NEW
  #
  # Action for ask the RFC key
  def new
    new_rfc = Rfc.create_if_not_exists(rfc_params)

    if new_rfc.valid?
      render json: new_rfc
    else
      byebug
    end
  end

  private

  # STRONG PARAMS
  def rfc_params
    params.permit(:name, :last_name, :second_last_name, :birthdate)
  end
end
