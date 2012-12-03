class TagsController < ApplicationController
  skip_authorization_check
  def index
    @tags = Package.tag_counts
  end

  def show
    @tag = params[:id]
    @packages = Package.tagged_with(@tag)
  end
end
