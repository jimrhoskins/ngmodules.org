class Package < ActiveRecord::Base
  include PgSearch

  def to_param
    name
  end

  pg_search_scope :fulltext_search,
    against: [:name, :github_repo, :description, :readme_markdown]
  acts_as_taggable
  attr_accessible :github_repo, :name, :description, :homepage, :readme_markdown, :tag_list

  validates :name, 
    format: /^[a-z0-9_\.-]+$/i,
    uniqueness: {case_sensitive: false}
  validates :github_repo, format: /^[a-z0-9][a-z0-9-]*\/[a-z0-9\._-]+$/i
  validates :description, presence: true


  belongs_to :owner, class_name: "User"
  belongs_to :submitter, class_name: "User"

  has_many :uses
  has_many :users, through: :uses

  before_save :associate_user

  scope :sort, lambda { |sort|
    sort ||= 'popular'
    case sort
    when "newest"
      order "created_at DESC"
    when "all"
      order "name ASC"
    when 'popular'
      order "uses_count DESC, created_at DESC"
    end
  }

  def self.search(query)
    if query.present?
      fulltext_search(query)
    else
      scoped
    end
  end

  def github_user
    github_repo.split("/")[0].downcase
  end

  def github_url 
    "https://github.com/#{github_repo}"
  end

  def download_url
    "#{github_url}/archive/master.zip"
  end

  def readme_html
    Redcarpet::Markdown.new(
      AlbinoHTML,
      lax_spacing: true,
      fenced_code_blocks: true
    ).render(readme_markdown || '').html_safe
  end

  def claimed
    owner_id && owner_id == submitter_id
  end

  private

  def associate_user
    self.owner  = User.find_or_create_by_github github_user
  end


end

class AlbinoHTML < Redcarpet::Render::HTML
  def block_code(code, language)
    language ||= "text"
    Albino.colorize(code, language)
  end
end
