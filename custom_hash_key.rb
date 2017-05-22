class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def eql?(other)
    self.class === other &&
      name == other.name
  end

  def hash
    name.hash
  end
end

p1 = Person.new("Martin")
p2 = Person.new("Martin")

puts p1.eql?(p2)
puts p1.hash == p2.hash

h = { p1 => "Found me" }
puts h[p1]
puts h[p2]

