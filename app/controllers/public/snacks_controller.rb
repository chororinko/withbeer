class Public::SnacksController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]
  before_action :is_matching_login_customer, only: [:edit, :update, :destroy]

  def new
    @snack = Snack.new
    @sakes = Sake.all
  end

  def create
    @snack = Snack.new(snack_params)
    @snack.customer_id = current_customer.id
    if @snack.save
      flash[:notice] = 'おつまみレシピの新規投稿に成功しました。'
      redirect_to snack_path(@snack)
    else
      flash[:notice] = 'おつまみレシピの新規投稿に失敗しました。'
      render :new
    end
  end

  def index
    @snacks = Snack.page(params[:page])
    @sake = Sake.find(params[:sake_id])
    @quantity = @sake.snacks.count
  end

  def show
    @snack = Snack.find(params[:id])
    @customer = @snack.customer
  end

  def edit
    @snack = Snack.find(params[:id])
  end

  def update
    @snack = Snack.find(params[:id])
    if @snack.update(snack_params)
      flash[:notice] = 'おつまみレシピの編集に成功しました。'
      redirect_to snack_path(@snack)
    else
      flash[:notice] = 'おつまみレシピの編集に失敗しました。'
      render :edit
    end
  end

  def destroy
    snack = Snack.find(params[:id])
    snack.destroy
    redirect_to mypage_path
  end

  private

  def snack_params
    params.require(:snack).permit(:image, :title, :introduction, :ingredients, :process, :sake_id)
  end

  def is_matching_login_customer
    snack = Snack.find(params[:id])
    unless snack.customer_id == current_customer.id
      redirect_to snacks_path
    end
  end

end
