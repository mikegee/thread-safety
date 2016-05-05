class Foo
  RANDOMNESS = File.open('/dev/random')

  def self.bar(arg)
    @arg = arg
    RANDOMNESS.getc
    @arg == arg
  end
end

require 'securerandom'

25.times.map do
  Thread.new do
    results = Array.new(1000) do
      Foo.bar(SecureRandom.hex)
    end
    p results.count
  end
end.each(&:join)

