class Admin::SakesController < ApplicationController

  def create
    @sake = Sake.new(sake_params)
    if @sake.save
      flash[:notice] = 'お酒のジャンル登録に成功しました。'
      redirect_to request.referer
    else
      @sakes = Sake.all
      flash[:notice] = 'お酒のジャンル登録に失敗しました。'
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
      flash[:notice] = 'お酒のジャンル編集に成功しました。'
      redirect_to admin_sakes_path
    else
      flash[:notice] = 'お酒のジャンル編集に失敗しました。'
      redirect_to request.referer
    end
  end

  def destroy
    sake = Sake.find(params[:id])
    sake.destroy
    flash[:notice] = 'お酒を削除しました。'
    redirect_to admin_sakes_path
  end

  def sake_params
    params.require(:sake).permit(:genre)
  end

end
