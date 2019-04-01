Spree::UsersController.class_eval do

  def update
    if @user.update_attributes(user_params)
      if params[:user][:password].present?
        # this logic needed b/c devise wants to log us out after password changes
        user = Spree::User.reset_password_by_token(params[:user])
        sign_in(@user, event: :authentication, bypass: !Spree::Auth::Config[:signout_after_password_change])
      end

      respond_to do |format|
        format.html { redirect_to spree.account_url, notice: Spree.t(:account_updated) }
        format.json { render json: { success: Spree.t(:account_updated) }, status: 200 }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @user.errors, status: 422 }
      end
    end
  end

end
