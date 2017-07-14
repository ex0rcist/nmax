module Nmax
  class IO
    NUMBERS = ('0'..'9').freeze
    CHUNK_ADD_READ = 1 # additional read to complete number, "broken" by cursor

    def initialize(io, chunk_size = 8092)
      @io = io
      @chunk_size = chunk_size
    end

    def read(chunk_size = nil)
      return nil if @io.eof?

      size = chunk_size || @chunk_size

      content = @io.read(size)

      if content && number?(content[-1])
        added_read = read(CHUNK_ADD_READ).to_s
        content += added_read if number?(added_read)
      end

      content
    end

    private

    def number?(s)
      NUMBERS.cover?(s)
    end
  end
end
