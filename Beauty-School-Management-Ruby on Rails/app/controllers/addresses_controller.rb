class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.build(address_params)
    if @address.save
      flash[:success] = "Contact saved."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @address = Address.find(params[:id])
  end
  
  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(address_params)
      flash[:success] = "Contact updated."
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  
    def address_params
      params.require(:address).permit(:street, :city, :state_id, :zip, :phone)
    end
  
end
