class RfcSerializer < ActiveModel::Serializer
  attributes :rfc, :count

  def rfc
    object.key
  end
end
