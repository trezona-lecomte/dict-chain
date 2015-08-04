require "./node.rb"
require "pry-byebug"

START_WORD  = "ruby"
END_WORD    = "code"
WORD_LENGTH = END_WORD.length

dict_file = File.open("/usr/share/dict/words")
dict = File.readlines(dict_file).each { |l| l.chomp!.downcase! }

POSSIBLE_WORDS = dict.select { |word| word.length == WORD_LENGTH }

potential_paths = []

open_nodes = []

closed_nodes = []

shortest_path = 1000

open_nodes << Node.new(word: START_WORD, parent: nil, g: 0, h: 0)

until open_nodes.empty?
  current_node = open_nodes.min_by { |node| node.f }

  open_nodes.delete(current_node)

  successors = []
  POSSIBLE_WORDS.each do |word|
    diffs = 0
    word.chars.zip(current_node.word.chars).each do |a, b|
      diffs += 1 if a != b
    end

    if diffs == 1
      h = 0
      END_WORD.chars.zip(word.chars).each do |a, b|
        h += 1 if a != b
      end

      successors << Node.new(word: word, parent: current_node, g: current_node.g + 1, h: h)
    end
  end

  successors.each do |successor|
    if successor.word == END_WORD
      if successor.g < shortest_path
        shortest_path = successor.g
      end
      potential_paths << successor
      break
    end

    if successor.g < shortest_path
      better_nodes = []
      better_nodes << open_nodes.detect {|node| node.word == successor.word && node.f < successor.f }
      better_nodes << closed_nodes.detect {|node| node.word == successor.word && node.f < successor.f }

      if better_nodes.compact.empty?
        open_nodes << successor
      end
    end
  end
  closed_nodes << current_node
end

puts potential_paths.min_by { |node| node.g }.words_to_here
