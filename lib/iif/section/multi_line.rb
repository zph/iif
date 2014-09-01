module IIF
  module Section
    class MultiLine < Base
      def string_scanner
        super
      end

      def extract
      end

      # def extract
      # end

      # def clean_headers(heads)
      #   normalize_rows(Array(heads), "!ENDTRNS").first.each_with_object({}) do |row, obj|
      #     row = row.map(&:to_sym)
      #     obj[row.first.to_s.lchomp('!').to_sym] = row[1..-1]
      #   end
      # end

      # def clean_transactions(trans)
      #   key = "ENDTRNS"
      #   row = normalize_rows(trans, key)
      # end

      # def normalize_rows(rows, end_stub)
      #   rows.map do |row|
      #     row.strip
      #     .split("\r\n")
      #     .reject { |i| i == end_stub }
      #     .map { |r| r.split("\t") }
      #   end
      # end

      # def attach_key_to_values(transaction, header)
      #   transaction.each_with_object({}) do |row, obj|
      #     column_headers = header[row.first.to_sym].map(&:downcase)
      #     values = row[1..-1]
      #     hsh = column_headers.zip(values)
      #     obj[row.first.downcase.to_sym] = Hash[hsh]
      #   end
      # end
    end
  end
end
