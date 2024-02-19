module ApplicationHelper
  def markdown_to_html(content)
    renderer = Redcarpet::Render::HTML.new(filter_html: true)
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    markdown.render(content).html_safe
  end
end
