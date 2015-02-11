class PoopsController < ApplicationController

  def create
    Time.zone = "EST"
    Chronic.time_class = Time.zone
    @pet = Pet.find(poop_params[:pet_id])
    @poop = Poop.new(pet_id: poop_params[:pet_id], poop_quality: poop_params[:poop_quality])
    @date = Chronic.parse(params[:poop_datetime])
    @poop.poop_datetime = @date
    respond_to do |format|
      if @poop.save
        format.html { redirect_to pet_path(@pet) }
      else
        format.html { redirect_to pet_path(@pet), notice: "No poop added to schedule - poops must include quality and a valid date"}
      end
    end
  end

  def destroy
    @poop = Poop.find(params[:id])
    @pet = @poop.pet
    @poop.destroy
    redirect_to pet_path(@pet)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def poop_params
      params.require(:poop).permit(:poop_datetime, :pet_id, :walker_id, :poop_quality)
    end

end
