require 'redcarpet'
require 'redcarpet/render_strip'

class MarkdownRenderer
  def self.render(text)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    renderer.render(text).html_safe
  end
end