class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    
    @listing = Listing.find(params[:listing_id])
    
  end

  def create
    @reservation = current_user.reservations.new(reservation_params) 

    @reservation.save

    redirect_to new_listing_reservations_payments_path, :flash => { :success => "Reservation saved!" }

  end

  def index

    @user_reservations = User.find(params[:user_id]).reservations
  
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :listing_id, :start_date, :end_date)
  end


end
