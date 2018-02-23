class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    
    @listing = Listing.find(params[:listing_id])
    
  end

  def create
    @reservation = current_user.reservations.new(reservation_params) 
    #current_user is a way around passing the parameter of user_id into this as you can't add on :user_id in the brackets by referring to the association between user and reservations
    #reservation_params will also include the hidden field of listing_id, which is how it gets passed in

    #<%= p.hidden_field :listing_id, :value => @listing.id %> - we are now using this
    #could use this in controller for same results - @reservation.listing_id = @listing.id

    @reservation.save

    redirect_to new_listing_reservations_payments_path, :flash => { :success => "Reservation saved!" }

  end

  def index
    @user_reservations = current_user.reservations
  
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :listing_id, :start_date, :end_date)
  end


end
