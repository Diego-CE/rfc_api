class RfcSerializer < ActiveModel::Serializer
  attributes :rfc, :count

  # RFC
  #
  # Method for rename attribute 'key' to 'rfc'
  def rfc
    object.key
  end
end
