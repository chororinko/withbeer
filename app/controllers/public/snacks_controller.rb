class Public::SnacksController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show, :search_tag]
  before_action :is_matching_login_customer, only: [:edit, :update, :destroy]

  def new
    @snack = Snack.new
    @sakes = Sake.all
    @tags = @snack.tags.pluck(:name).join(',')
  end

  def create
    @snack = Snack.new(snack_params)
    @snack.customer_id = current_customer.id
    tags = params[:snack][:name].split(',')
    if @snack.save
      @snack.save_tags(tags)
      flash[:notice] = 'おつまみレシピの新規投稿に成功しました。'
      redirect_to snack_path(@snack)
    else
      flash[:notice] = 'おつまみレシピの新規投稿に失敗しました。'
      render :new
    end
  end

  def index
    @sake = Sake.find(params[:sake_id])
    @snacks = @sake.snacks.order(created_at: :desc).page(params[:page])
    @quantity = @sake.snacks.count
    @tags = Tag.all
  end

  def show
    @snack = Snack.find(params[:id])
    if @snack.customer.present?
      @customer = @snack.customer.id
    else
      @customer = nil
    end
    @snack_comment = SnackComment.new
    @snack_comments = @snack.snack_comments.order(created_at: :desc).page(params[:page]).per(6)
    @tags = @snack.tags.pluck(:name).join(',')
    @snack_tags = @snack.tags
  end

  def edit
    @snack = Snack.find(params[:id])
    @tags = @snack.tags.pluck(:name).join(',')
  end

  def update
    @snack = Snack.find(params[:id])
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
    snack = Snack.find(params[:id])
    snack.destroy
    flash[:notice] = '投稿を削除しました。'
    redirect_to customer_path(current_customer)
  end

  def search_tag
    @tags = Tag.all
    @tag = Tag.find(params[:tag_id])                     #特定のタグを受け取る
    @snacks = @tag.snacks.order(created_at: :desc).page(params[:page])     #特定のタグに紐づく投稿を表示
    @quantity = @tag.snacks.count                       # タグに紐づくおつまみの数
  end

  private

  def snack_params
    params.require(:snack).permit(:image, :title, :introduction, :ingredients, :process, :sake_id, snack_tag_ids: [])
  end

  def is_matching_login_customer
    snack = Snack.find(params[:id])
    unless snack.customer_id == current_customer.id
      redirect_to snacks_path
    end
  end

end
