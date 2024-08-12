ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  actions :index, :show, :edit

  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    def create
      @user = User.new(
        permitted_params[:user].merge(
          {
            password: 'password', password_confirmation: 'password'
            }
          )
        )

      if @user.save
        redirect_to admin_user_path(@user)
      else
        render :new
      end
    end

    def update
      @user = User.find(params[:id])
      if @user.update(permitted_params[:user])
        redirect_to admin_user_path(@user)
      else
        render :edit
      end
    end
  end


  form do |f|
    f.inputs "#{resource.email}" do
      f.input :name
    end
    f.actions
  end
end
