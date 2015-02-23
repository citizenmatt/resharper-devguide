require 'yaml'
require 'json'
require 'kramdown'

module UpsourceDocs
  class TocGenerator

    ITEM_TYPE_HEADER = 'header'

    # @param path {String} path to Markdown file
    # @param kramdown_config {Hash} Kramdown config
    # @return {Hash}
    def self.extract(path, kramdown_config = {})
      toc = []
      content = File.read(path)
      kramdown_config = kramdown_config.merge({:html_to_native => true})
      kramdown_doc = Kramdown::Document.new(content, kramdown_config)

      kramdown_doc.root.children.each do |c|
        item = extract_from_node(c)
        toc.concat(item) if item != nil
      end

      # Removing headers of empty sections
      delete_list = []
      (0).upto(toc.length-1) do |i|
        item = toc[i]
        prev = toc[i-1] != nil ? toc[i-1] : nil
        item_is_header = (item[:type] != nil and item[:type] == self::ITEM_TYPE_HEADER)
        prev_is_header = (prev != nil and prev[:type] != nil and prev[:type] == self::ITEM_TYPE_HEADER)

        if item_is_header and prev_is_header
          delete_list.push(i-1)
        end
      end

      delete_list.each do |del_index|
        toc.delete_at(del_index)
      end

      return toc
    end


    private
    def self.extract_from_node(node)
      items = []

      case node.type
        when :ul
          items.concat(extract_items(node))

        when :header
          items.push(extract_header(node)) if node.options[:level] == 2
      end

      return items.length > 0 ? items : nil
    end

    def self.extract_items(ul_node)
      items = []

      ul_node.children.select { |n| n.type == :li }.each do |li_node|
        items.push(extract_item(li_node))
      end

      return items
    end

    def self.extract_item(li_node)
      item = {}

      p = li_node.children[0]
      case p.children[0].type
        when :text
          item[:title] = p.children[0].value.strip

        when :a
          a = p.children[0]
          href = a.attr['href']
          href = href.chomp(File.extname(href)) + '.html'
          item[:id] = File.basename(href, File.extname(href))
          item[:title] = a.children[0].value.strip
          item[:url] = href
          is_external = href.start_with?('http://', 'https://', 'ftp://', '//')
          item[:is_external] = true if is_external
      end

      li_node.children.drop(1).each do |child|
        pages = extract_items(child) if child.type == :ul
        item[:pages] = pages if pages != nil
      end

      return item
    end

    def self.extract_header(header_node)
      return {
        :title => header_node.options[:raw_text].strip,
        :type => self::ITEM_TYPE_HEADER
      }
    end
  end
end
