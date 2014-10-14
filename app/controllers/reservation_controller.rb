class ReservationController < ApplicationController

  def create
    reservations = Reservation.where email: params[:email]
    if reservations.length < 1
      reservations = Reservation.create email: params[:email]
    end
    session[:reservation_email] = reservations.first.email
    redirect_to controller: :home, action: :email_capture
  end

end
