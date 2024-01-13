class Admin::RecommendationsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @snack = Snack.new
    @sakes = Sake.all
    @tags = @snack.tags.pluck(:name).join(',')
  end

  def create
    @snack = Snack.new(recommendation_params)
    @snack.customer_id = current_customer.id
    tags = params[:snack][:name].split(',')
    if @snack.save
      @snack.save_tags(tags)
      flash[:notice] = '今月のおすすめの新規登録に成功しました。'
      redirect_to admin_recommendation_path(@snack)
    else
      flash[:notice] = '今月のおすすめの新規登録に失敗しました。'
      render :new
    end
  end

  def index
    @snacks = Snack.page(params[:page])
    @sake = Sake.find(params[:sake_id])
    @quantity = @sake.snacks.count
    @tags = Tag.all
  end

  def show
    @snack = Snack.find(params[:snack_id])
    @customer = @snack.customer.id
    @snack_comment = SnackComment.new
    @tags = @snack.tags.pluck(:name).join(',')
    @snack_tags = @snack.tags
  end

  def edit
    @snack = Snack.find(params[:snack_id])
    @tags = @snack.tags.pluck(:name).join(',')
  end

  def update
    @snack = Snack.find(params[:snack_id])
    tags = params[:snack][:name].split(',')
    if @snack.update(snack_params)
      @snack.save_tags(tags)
      flash[:notice] = 'おつまみレシピの編集に成功しました。'
      redirect_to snack_path(@snack)
    else
      flash[:notice] = 'おつまみレシピの編集に失敗しました。'
      render :edit
    end
  end

  def destroy
    snack = Snack.find(params[:snack_id])
    snack.destroy
    redirect_to customer_path(current_customer)
  end

  private

  def recommendation_params
    params.require(:snack).permit(:snack_id, :sake_id, :tag_id)
  end

end
