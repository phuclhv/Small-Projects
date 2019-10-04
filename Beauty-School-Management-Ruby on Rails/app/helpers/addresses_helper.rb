module AddressesHelper
  def has_address?(user)
    @address = user.addresses.first
    !@address.nil?
  end
end
