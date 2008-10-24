require 'date'

module ONIX

  # Internal class representing XML content date binding
  #
  # In context:
  #  <element attribute="XMLAttributeRef">
  #   XMLYYYYMMDDRef
  #  </element>
  class DateType < ROXML::XMLRef # ::nodoc::
    attr_reader :cdata, :content

    def initialize(accessor, args, &block)
      super(accessor, args, &block)
      @content = args.content?
      @cdata = args.cdata?
    end

    # Updates the text in the given _xml_ block to
    # the _value_ provided.
    def update_xml(xml, value)
      parent = wrap(xml)
      add(parent.child_add(LibXML::XML::Node.new_element(name)), value.strftime("%Y%m%d"))
      xml
    end

    def value(xml)
      begin
        if content
          value = Date.parse(xml.content.strip)
        else
          child = xml.search(name).first
          value = Date.parse(child.content.strip) if child
        end
      rescue ArgumentError
        value = nil
      end
      block ? block.call(value) : value
    end

    private

    def add(dest, value)
      if cdata
        dest.child_add(LibXML::XML::Node.new_cdata(value.to_utf))
      else
        dest.content = value.to_utf
      end
    end
  end
end

ROXML::TypeRegistry.register(:yyyymmdd, ONIX::DateType)
