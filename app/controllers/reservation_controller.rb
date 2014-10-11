class ReservationController < ApplicationController

  def create
    reservation = Reservation.create email: params[:email]
    redirect_to 'home/email_capture', flash: { message: 'Thanks! We\'ll drop you a line soon.' }
  end

end
