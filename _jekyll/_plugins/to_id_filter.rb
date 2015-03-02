module Jekyll
  module ToIdFilter
    def to_id(input)
      puts input
      puts input.sub(/^\//, '').sub(/.html$/, '')
      puts
      input.sub(/^\//, '').sub(/.html$/, '')
    end
  end
end

Liquid::Template.register_filter(Jekyll::ToIdFilter)
