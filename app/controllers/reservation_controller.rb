class ReservationController < ApplicationController

  def create
    reservation = Reservation.create email: params[:email]
    cookies[:reservation_email] = reservation.email
    redirect_to 'home/email_capture'
  end

end
