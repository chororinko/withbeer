class Admin::SakesController < ApplicationController

  def create
    @sake = Sake.new(sake_params)
    if @sake.save
      redirect_to request.referer
    else
      @sakes = Sake.all
      redirect_to request.referer
    end
  end

  def index
    @sakes = Sake.all
    @sake = Sake.new
  end

  def edit
    @sake = Sake.find(params[:id])
  end

  def update
    @sake = Sake.find(params[:id])
    if @sake.update(sake_params)
      redirect_to admin_sakes_path
    else
      redirect_to request.referer
    end
  end

  def destroy
    sake = Sake.find(params[:id])
    sake.destroy
    redirect_to admin_sakes_path
  end

  def sake_params
    params.require(:sake).permit(:genre)
  end

end
