class ReservationController < ApplicationController

  def create
    reservation = Reservation.create email: params[:email]
    session[:reservation_email] = reservation.email
    redirect_to controller: :home, action: :email_capture
  end

end
