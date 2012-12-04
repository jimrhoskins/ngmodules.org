class PermittedParams < Struct.new(:params, :user)
  def package
    params.require(:package).permit(*package_attributes)
  end

  def package_attributes
    [
      :name,
      :github_repo,
      :description,
      :homepage,
      :tag_list,
      :readme_markdown
    ]
  end
end
