require "./spec_helper"

module Lolcat::Lol
  extend self
end

describe Lolcat::Lol do
  describe "#rainbow_color" do
    it "returns the correct color" do
      Lolcat::Lol.rainbow_color(0.0, 0.1).should eq({127, 236, 17})
      Lolcat::Lol.rainbow_color(1.0, 0.1).should eq({139, 230, 11})
      Lolcat::Lol.rainbow_color(2.0, 1.0).should eq({242, 23, 115})
      Lolcat::Lol.rainbow_color(1.0, 2.0).should eq({242, 23, 115})
    end
  end
end
