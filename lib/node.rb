class Node
  attr_reader :parent, :word, :f, :g, :h

  def initialize(word:, parent:, g:, h:)
    @word = word
    @parent = parent
    @g = g
    @h = h
    @f = g + h
  end

  def words_to_here
    ancestor = parent
    family_tree = [self]

    while ancestor
      family_tree << ancestor
      ancestor = ancestor.parent
    end

    family_tree.map do |member|
      member.word
    end.reverse
  end
end
