class Poker
  # TODO パラメータを柔軟に
  def initialize(hand)
    @hands = hand.gsub(/A/, "Z").gsub(/T/, "B").gsub(/K/, "Y").split(/ /)
  end

  def rank
    nums = @hands.map {|v| v[0] }
    base = nums.sort.reverse
    if royal?
      "J#{base.join}"
    elsif straight_flush?
      "I#{base.join}"
    elsif four?
      hit = nums.select {|v| nums.count(v) == 4 }.first
      "H#{hit * 4}#{base.reject {|v| v == hit}.join}"
    elsif full_house?
      hit1 = nums.select {|v| nums.count(v) == 3 }.first
      hit2 = nums.select {|v| nums.count(v) == 2 }.first
      "G#{hit1 * 3}#{hit2 * 2}"
    elsif flush?
      "F#{base.join}"
    elsif straight?
      "E#{base.join}"
    elsif three?
      hit = nums.select {|v| nums.count(v) == 3 }.first
      "D#{hit * 3}#{base.reject {|v| v == hit}.join}"
    elsif two_pair?
      hit1 = nums.select {|v| nums.count(v) == 2 }.max
      hit2 = nums.select {|v| nums.count(v) == 2 }.min
      "C#{hit1 * 2}#{hit2 * 2}#{base.reject {|v| v == hit1 or v == hit2}.join}"
    elsif one_pair?
      hit = nums.select {|v| nums.count(v) == 2 }.first
      "B#{hit * 2}#{base.reject {|v| v == hit}.join}"
    else
      "A#{base.join}"
    end
  end

  def one_pair?
    nums = @hands.map {|x| x[0] }
    if nums.group_by {|e| nums.count(e) }.keys.max == 2 and
       nums.group_by {|e| nums.count(e) }[2].uniq.size == 1
      return true
    end
    false
  end

  def two_pair?
    nums = @hands.map {|x| x[0] }
    if nums.group_by {|e| nums.count(e) }.keys.max == 2 and
       nums.group_by {|e| nums.count(e) }[2].uniq.size == 2
      return true
    end
    false
  end

  def three?
    nums = @hands.map {|x| x[0] }
    if nums.group_by {|e| nums.count(e) }.keys.max == 3
      return true
    end
    false
  end

  def straight?
    nums = @hands.map {|x| x[0] }
    if nums.include?("2")
      nums.map! {|v| v.gsub("Z", "1") }
    else
      nums.map! {|v| v.gsub("Z", "14") }
    end
    nums.map! {|v| v.gsub("B", "10") }
    nums.map! {|v| v.gsub("J", "11") }
    nums.map! {|v| v.gsub("Q", "12") }
    nums.map! {|v| v.gsub("Y", "13") }
    if nums.uniq.size == 5 and
       nums.map {|v| v.to_i }.max - nums.map {|v| v.to_i }.min == 4
      return true
    end
    false
  end

  def flush?
    if @hands.map {|x| x[1] }.uniq.size == 1
      return true
    end
    false
  end

  def full_house?
    nums = @hands.map {|x| x[0] }
    if nums.uniq.size == 2 and
       nums.group_by {|e| nums.count(e) }.keys.max == 3
      return true
    end
    false
  end

  def four?
    nums = @hands.map {|x| x[0] }
    if nums.group_by {|e| nums.count(e) }.keys.max == 4
      return true
    end
    false
  end

  def straight_flush?
    if straight? and flush?
      return true
    end
    false
  end

  def royal?
    if @hands.map {|x| x[1] }.uniq.size == 1 and
       @hands.map {|x| x[0] }.sort == %w[B J Q Y Z]
      return true
    end
    false
  end
end
