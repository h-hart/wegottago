class ReservationController < ApplicationController

  def create
    reservations = Reservation.where email: reservation_params[:email]
    if reservations.length < 1
      reservations.push Reservation.create email: reservation_params[:email]
    end
    session[:reservation_email] = reservations.first.email
    redirect_to controller: :home, action: :email_capture
  end
  
  def reservation_params
    params[:reservation]
  end

end
