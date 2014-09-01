module IIF
  module Section
    class Base
      include Anima.new(:content)
      extend Memoist

      def scanner
        @scanner ||= StringScanner.new(content)
      end

      def extract
        raise(ArgumentError, "Must be implemented in child class.")
      end

      def string_process
        scanner.reset
      end

      def body(rows)
        rows.map do |row|
          split_row(row)
        end
      end

      def sanitize_header(string)
        row = split_row(string)
        key = row.first.to_s.lchomp('!').to_sym
        array = row[1..-1].map { |i| i.downcase.to_sym }
        {key => array}
      end

      def split_row(row)
        row.chomp_split
      end

      def extract
        header, rows = string_process.values_at(:header, :body)
        output = hash_template(header.keys)

        value = rows.each_with_object(output) do |row, obj|
          key = row.first.to_sym
          obj[key] << Hash[header[key].zip(row[1..-1])]
        end
      end
      alias_method :to_hash, :extract
      memoize :extract

      def hash_template(types)
        types.each_with_object({}) do |t, obj|
          obj[t] = []
        end
      end
    end
  end
end
