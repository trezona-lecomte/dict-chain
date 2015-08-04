require "spec_helper"
require "chainer"

RSpec.describe Chainer do
  let(:chainer) { Chainer.new(dict: File.open("/usr/share/dict/words")) }

  context "when the words given are cat and dog" do
    let(:start_word) { "cat" }
    let(:end_word)   { "dog" }
    let(:chain)      { chainer.chain(start: start_word, end: end_word) }

    it "returns a chain of words between cat and dog" do
      expect(chain).to eq(%w(cat cot cog dog))
    end
  end
end
