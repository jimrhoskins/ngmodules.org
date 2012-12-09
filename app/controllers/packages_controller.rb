class PackagesController < ApplicationController
  before_filter :load_package, except: [:index, :new, :create]
  authorize_resource except: [:like]

  def index
    @packages = Package.search(params[:query]).sort(params[:sort]).page(params[:page]).per(15)
    respond_to do |format|
      format.html
      format.atom { render layout: false}
    end
  end

  def new
    @package = Package.new
  end

  def show
  end

  def edit
  end

  def create
    @package = current_user.submitted_packages.build(permitted_params.package)
    if @package.save
      redirect_to @package
    else
      render action: :new
    end
  end

  def update
    if @package.update_attributes(permitted_params.package)
      redirect_to @package
    else
      render action: :edit
    end
  end

  def destroy
    @package.destroy
    redirect_to Package, notice: "Package #{@package.name} has been removed."
  end

  def like
    authorize! :read, @package
    if current_user
      current_user.does_use(@package)
    else
      flash[:error] = "You must be logged in to tell the world you use this module."
    end
    redirect_to @package
  end

  def dislike
    authorize! :read, @package

    current_user.does_not_use(@package) if current_user
    redirect_to @package
  end

  private

  def load_package 
    @package = Package.find_by_name!(params[:id])
  end
end
