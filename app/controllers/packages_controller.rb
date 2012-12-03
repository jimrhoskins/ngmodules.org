class PackagesController < ApplicationController
  before_filter :load_package, except: [:index, :new, :create]
  authorize_resource  except: [:like]
  #skip_authorization_check only: [:like]


  def index
    @packages = Package.search(params[:query])
  end

  def new
    @package = Package.new
  end

  def show
  end

  def edit
  end

  def create
    @package = current_user.submitted_packages.build(params[:package])
    if @package.save
      redirect_to @package
    else
      render action: :new
    end
  end

  def update
    if @package.update_attributes(params[:package])
      redirect_to @package
    else
      render action: :edit
    end
  end

  def destroy
    @package.destroy
    redirect_to Package
  end

  def like
    authorize! :read, @package
    if current_user
      Use.find_or_create_by_user_id_and_package_id(current_user.id, params[:id])
    else
      flash[:error] = "You must be logged in to tell the world you use this module."
    end
    redirect_to @package
  end

  def dislike
    authorize! :read, @package
    if current_user
      use = Use.find_by_user_id_and_package_id(current_user.id, params[:id])
      use.destroy if use
    end
    redirect_to @package
  end

  private

  def load_package 
    @package = Package.find(params[:id])
  end
end
