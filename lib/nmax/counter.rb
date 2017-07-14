require 'set'

module Nmax
  class Counter
    DELIM = ' '.freeze

    attr_reader :numbers

    def initialize(io, limit)
      @io = io
      @limit = limit

      @numbers = []
      @set = SortedSet.new

      @numbers_min = 0
      @numbers_max = 0
      count!
    end

    def count!
      while (str = @io.read)
        str.tr!('^0-9', DELIM)
        numbers = str.split(DELIM)

        numbers.each do |n|
          @set.add n.to_i

          # @set.replace(@set.max(@limit)) if @set.length > @limit * 3
        end

        # @numbers.concat numbers.map(&:to_i)
        #
        # if @numbers.length > @limit
        #   @numbers.uniq!
        #   @numbers = @numbers.max(@limit)
        # end
      end

      @numbers = @set.max(@limit)
    end
  end
end
