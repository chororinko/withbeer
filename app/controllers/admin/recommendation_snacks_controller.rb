class Admin::RecommendationSnacksController < ApplicationController
  before_action :authenticate_admin!, except: [:show]
  before_action :set_snack, only: [:show, :edit, :update]

  def new
    @snack = Snack.new
    @sakes = Sake.all
    @tags = @snack.tags.pluck(:name).join(',')
  end

  def create
    @snack = Snack.new(snack_params)
    tags = params[:snack][:name].split(',')
    if @snack.save
      @snack.save_tags(tags)
      flash[:notice] = '今月のおすすめの新規登録に成功しました。'
      redirect_to admin_recommendation_snack_path(@snack)
    else
      flash[:notice] = '今月のおすすめの新規登録に失敗しました。'
      render :new
    end
  end

  def index
    @snacks = Snack.where(customer_id: nil).order(created_at: :desc).page(params[:page])
    @sakes = Sake.all
  end

  def show
    @snack_comments = @snack.snack_comments.order(created_at: :desc).page(params[:page]).per(6)
    @tags = @snack.tags.pluck(:name).join(',')
    @snack_tags = @snack.tags
  end

  def edit
    @tags = @snack.tags.pluck(:name).join(',')
  end

  def update
    tags = params[:snack][:name].split(',')
    if @snack.update(snack_params)
      @snack.save_tags(tags)
      flash[:notice] = 'おつまみレシピの編集に成功しました。'
      redirect_to admin_recommendation_snack_path(@snack)
    else
      flash[:notice] = 'おつまみレシピの編集に失敗しました。'
      render :edit
    end
  end

  def destroy
    snack = Snack.find(params[:id])
    snack.destroy
    flash[:notice] = '今月のおすすめを削除しました。'
    redirect_to admin_root_path
  end

  private

  def snack_params
    params.require(:snack).permit(:image, :title, :introduction, :ingredients, :process, :sake_id)
  end

  def set_snack
    @snack = Snack.find(params[:id])
  end

end
