require "./spec_helper"

module Lolcat::Lol
  extend self
end

describe Lolcat::Lol do
  describe "#rainbow_color" do
    it "returns the correct color" do
      color = Lolcat::Lol.rainbow_color(0.0, 0.1)
      color.should eq({127, 236, 17})
      color = Lolcat::Lol.rainbow_color(1.0, 0.1)
      color.should eq({139, 230, 11})
    end
  end
end
