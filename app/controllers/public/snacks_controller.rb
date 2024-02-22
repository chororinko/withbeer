class Public::SnacksController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show, :search_tag]
  before_action :is_matching_login_customer, only: [:edit, :update, :destroy]
  before_action :set_snack, only: [:show, :edit, :update]
  before_action :set_tags, only: [:new, :show, :edit]

  def new
    @snack = Snack.new
    @sakes = Sake.all
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
      @tags = params[:snack][:name]
      flash[:notice] = 'おつまみレシピの新規投稿に失敗しました。'
      render :new
    end
  end

  def index
    @sake = Sake.find(params[:sake_id])
    @snacks = @sake.snacks.order(created_at: :desc).page(params[:page])
    if params[:latest]
      @snacks = @sake.snacks.latest.page(params[:page])
    elsif params[:old]
      @snacks = @sake.snacks.old.page(params[:page])
    elsif params[:most_favorited]
      @snacks = @sake.snacks.most_favorited.page(params[:page])
    end
    @quantity = @sake.snacks.count
    @tags = Tag.all
  end

  def show
    if @snack.customer.present?
      @customer = @snack.customer.id
    else
      @customer = nil
    end
    @snack_comment = SnackComment.new
    @snack_comments = @snack.snack_comments.order(created_at: :desc).page(params[:page]).per(6)
    @snack_tags = @snack.tags
  end

  def edit
  end

  def update
    tags = params[:snack][:name].split(',')
    if @snack.update(snack_params)
      @snack.save_tags(tags)
      flash[:notice] = 'おつまみレシピの編集に成功しました。'
      redirect_to snack_path(@snack)
    else
      @tags = params[:snack][:name]
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
    if params[:latest]
      @snacks = @tag.snacks.latest.page(params[:page])
    elsif params[:old]
      @snacks = @tag.snacks.old.page(params[:page])
    elsif params[:most_favorited]
      @snacks = @tag.snacks.most_favorited.page(params[:page])
    end
    @quantity = @tag.snacks.count                       # タグに紐づくおつまみの数
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

  def set_snack
    @snack = Snack.find(params[:id])
  end

  def set_tags
    @tags = @snack.tags.pluck(:name).join(',')
  end

end
