class ReservationController < ApplicationController

  def create
    reservation = Reservation.create email: params[:email]
    render template: 'home/email_capture', layout: 'pre_launch', locals: { message: 'Thanks! We\'ll drop you a line soon.' }
  end

end
