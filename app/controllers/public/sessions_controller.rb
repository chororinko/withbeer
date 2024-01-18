# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_state, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end
  def after_sign_in_path_for(resource)
    customer_path(current_customer)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  # POST /resource/sign_in
  # def create
  #   super
  # end
  def guest_sign_in         # これだけでログインできるデバイス特有の機能
    customer = Customer.guest       # モデルで定義したものがCustomerに格納されている
    sign_in customer       # 上で定義したcustomer情報でログインする
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  private
  # アクティブであるかを判断するメソッド
  def customer_state
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
    return if @customer.nil?
    # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    return unless @customer.valid_password?(params[:customer][:password])
    # 【処理内容4】 アクティブでない会員に対する処理
    return if @customer.is_active == true

    if @customer.is_active == false
      flash[:danger] = 'お客様は退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
      redirect_to new_customer_registration_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
