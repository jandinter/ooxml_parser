require_relative 'ooxml_shift'
module OoxmlParser
  class TransformEffect
    attr_accessor :offset, :extents, :child_offset, :child_extent

    def initialize(offset = nil, extents = nil)
      @offset = offset
      @extents = extents
    end

    def self.parse(transform_effect_node)
      transform_effect = TransformEffect.new
      transform_effect_node.xpath('*').each do |transform_effect_node_child|
        case transform_effect_node_child.name
        when 'ext'
          transform_effect.extents = OOXMLShift.parse(transform_effect_node_child, 'cx', 'cy')
        when 'off'
          transform_effect.offset = OOXMLShift.parse(transform_effect_node_child)
        when 'chOff'
          transform_effect.child_offset = OOXMLShift.parse(transform_effect_node_child)
        when 'chExt'
          transform_effect.child_extent = OOXMLShift.parse(transform_effect_node_child, 'cx', 'cy')
        end
      end
      transform_effect
    end
  end
end
