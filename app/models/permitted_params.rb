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
  
  def blog_post
    params.require(:blog_post).permit(*blog_post_attributes)
  end

  def blog_post_attributes 
    [
      :title,
      :permalink,
      :content_markdown,
      :published_at,
      :published,
      :publish_now
    ]
  end
end
