#class MarkdownRenderer

  #def render(md) 
    #md ||= ''
    #Redcarpet::Markdown.new(
      #AlbinoHTML,
      #lax_spacing: true,
      #filter_html: true,

      #fenced_code_blocks: true
    #).render(md)
  #end
#end

#class AlbinoHTML < Redcarpet::Render::HTML
  #def block_code(code, language)
    #language ||= "text"
    #Albino.colorize(code, language)
  #end
#end

class MarkdownRenderer
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      language = "text" unless language.present?
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join('-') do
        Albino.colorize(code, language)
      end
    end
  end

  def markdown(text)
    text ||= ""
    renderer = HTMLwithPygments.new(filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end
