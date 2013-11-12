class AdminUserController < ApplicationController
  
  layout 'admin'
  before_filter :confirm_logged_in

  def index
    list
    render 'list'
  end

  def list
    # @admin_users = AdminUser.sorted
    @admin_users = AdminUser.order("admin_users.last_name ASC, admin_users.first_name ASC")
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(params[:admin_user].permit(:first_name, :last_name, :email, :password, :username))
    if @admin_user.save
      flash[:notice] = "User created"
      redirect_to(:action => 'list')
    else
      render('new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.update_attributes(params[:admin_user].permit(:first_name, :last_name, :email, :password, :username))
      flash[:notice] = "User updated"
      redirect_to(:action => 'list')
    else
      render('edit')
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    AdminUser.find(params[:id]).destroy
    flash[:notice] = "Page Deleted"
    redirect_to(:action => 'list')
  end
end
