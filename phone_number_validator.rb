class PhoneNumber
  def initialize number
    number.gsub!(/[\s-]*/, "")
    @number = number
  end

  def valid?
    @number =~ /^((\+\d{3,4})?\d{7,8})?$/
  end
  
  def to_s
    @number
  end
end

describe PhoneNumber do
  valid_numbers = ["", "1234567", "12 34 5678", "    1    2    3   4  5 6 7 8 ", "12-34-567", "+3721234567", "1----23-45  678"]
  valid_numbers.each do |valid_number|
    it "validates number #{valid_number} as valid" do
      PhoneNumber.new(valid_number).should be_valid,
                                           "expected #{valid_number} to be valid, but was not!"
    end
  end

  invalid_numbers = ["123456", "12a34567"]
  invalid_numbers.each do |invalid_number|
    it "validates number #{invalid_number} as invalid" do
      PhoneNumber.new(invalid_number).should_not be_valid,
                                                 "expected #{invalid_number} to be invalid, but was not!"
    end
  end
end