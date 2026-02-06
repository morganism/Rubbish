# Pipeline as Enumerators
class Stream
  def initialize(&block)
    @enum = Enumerator.new(&block)
  end

  def |(other)
    Stream.new do |y|
      @enum.each do |item|
        other.call(item, y)
      end
    end
  end
end

