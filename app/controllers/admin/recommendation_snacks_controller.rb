class Admin::RecommendationSnacksController < ApplicationController
  before_action :authenticate_admin!

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
    @snacks = Snack.page(params[:page])
    @sakes = Sake.all
  end

  def show
    @snack = Snack.find(params[:snack_id])
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
      redirect_to admin_recommendation_snack_path(@snack)
    else
      flash[:notice] = 'おつまみレシピの編集に失敗しました。'
      render :edit
    end
  end

  def destroy
    snack = Snack.find(params[:snack_id])
    snack.destroy
    redirect_to admin_root_path
  end

  # def search_tag
  #   @tags = Tag.all
  #   @tag = Tag.find(params[:tag_id])          #検索されたタグを受け取る
  #   @snacks = @tag.snacks.page(params[:page])    #検索されたタグに紐づく投稿を表示
  #   @quantity = @tag.snacks.count             # タグに紐づくおつまみの数
  # end

  private

  def snack_params
    params.require(:snack).permit(:image, :title, :introduction, :ingredients, :process, :sake_id, :tag_id)
  end

end
