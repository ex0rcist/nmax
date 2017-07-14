module Nmax
  class Tools
    class << self
      def profile
        m1, t1 = stats
        yield
        m2, t2 = stats

        puts "done in: #{(t2 - t1).round(3)}s"
        puts "memory used: #{((m2 - m1) / 1024.0).round(2)}Mb"
      end

      private

      def stats
        [memory_usage, current_time]
      end

      def memory_usage
        # roughly
        `ps ax -o pid,rss | grep -E "^[[:space:]]*#{$PROCESS_ID}"`.strip.split[1].to_i
      end

      def current_time
        Time.now.to_f
      end
    end
  end
end
