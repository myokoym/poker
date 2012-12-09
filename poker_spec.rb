require 'rspec'
require_relative 'poker'

describe Poker do
  it "high card" do
    Poker.new("1S 2H AS 4S 6S").rank.should == "AZ6421"
  end

  it "one pair" do
    Poker.new("AS 2H 3S 4S AS").rank.should == "BZZ432"
    Poker.new("9C KC AS 8D AD").rank.should == "BZZY98"
  end

  it "two pair" do
    Poker.new("AS 2H 2S 4S AS").rank.should == "CZZ224"
  end

  it "three of a kind" do
    Poker.new("AS AH 2S 4S AS").rank.should == "DZZZ42"
  end

  it "straight" do
    Poker.new("AS 5H 2S 4S 3S").rank.should == "EZ5432"
    Poker.new("JS KH QS AS TS").rank.should == "EZYQJB"
    Poker.new("JS QH QS AS TS").rank.should_not == "EZQQJB"
  end

  it "flush" do
    Poker.new("TS AS 2S 4S 3S").rank.should == "FZB432"
  end

  it "full house" do
    Poker.new("2S AS AH 2S 2S").rank.should == "G222ZZ"
  end

  it "four of a kind" do
    Poker.new("2S 2H AH 2S 2S").rank.should == "H2222Z"
  end

  it "straight flush" do
    Poker.new("9S QS TS JS 8S").rank.should == "IQJB98"
  end

  it "royal flush" do
    Poker.new("KS QS TS JS AS").rank.should == "JZYQJB"
  end
end
