class Guestuser::DataGuest

  GUEST_USER_EMAIL = "guest@example.com"

  def self.data_reset
    customer = Customer.find_by(email: GUEST_USER_EMAIL)
    customer.snacks.destroy_all
    customer.snack_comments.destroy_all
    customer.favorites.destroy_all
  end

end