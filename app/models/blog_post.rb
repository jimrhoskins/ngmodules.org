class BlogPost < ActiveRecord::Base
  validates_presence_of :title, :permalink, :content_markdown, :user_id
  belongs_to :user

  scope :published, lambda {
    where("published AND published_at < ?", Time.now)
  }

  def to_param
    permalink
  end

  def permalink=(value)
    value = value.downcase.gsub(/[ _]+/, '-')
    value = value.gsub(/[^a-z0-9-]/, '')
    write_attribute :permalink, value
  end

  def content_html
    MarkdownRenderer.new.markdown(content_markdown)
  end

  def publish_now=(value)
    if value
      self.published = true
      self.published_at = Time.now
    end
  end
end
