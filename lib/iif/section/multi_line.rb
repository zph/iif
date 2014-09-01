module IIF
  module Section
    class MultiLine < Base
      def string_process
        scanner.reset
        headers = scanner.scan_until(/^\!.*\r\n/)
        header = sanitize_header(headers)
        key = header.keys.first
        key_without_bang = key.to_s.lchomp('!')
        headers += scanner.scan_until(/^\!END#{key_without_bang}.*\r\n/) # discard end header line
        lines = []

        while !scanner.eos?
          match = scanner.scan_until(/#{key}.*\r\n/)
          if match.nil?
            break
          else
            lines << match
          end
        end

        {header: sanitize_full_header(headers), body: body(lines)}
      end

      def sanitize_header(string)
        row = split_row(string)
        key = row.first.to_s.lchomp('!').to_sym
        array = row[1..-1].map { |i| i.downcase.to_sym }
        {key => array}
      end

      def sanitize_full_header(string)
        rows = string.split("\r\n").map do |row|
          split_row(row)
        end

        rows.reject!{ |r| r.count == 1 }

        output = rows.each_with_object({}) do |row, obj|
          key = row.first.to_s.lchomp('!').to_sym
          array = row[1..-1].map { |i| i.downcase.to_sym }
          obj[key] = array
        end
      end
    end
  end
end
