class Public::SnacksController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]

  def new
    @snack = Snack.new
  end

  def create
    @snack = Snack.new(snack_params)
    if @snack.save
      flash[:notice] = 'おつまみの新規投稿に成功しました。'
      redirect_to snack_path(@snack)
    else
      flash[:notice] = 'おつまみの新規投稿に失敗しました。'
      render :new
    end
  end

  def index
    @snacks = Snack.all
  end

  def show
    @snack = Snack.find(params[:id])
  end

  private

  def snack_params
    params.require(:snack).permit(:image, :title, :introduction)
  end

end
