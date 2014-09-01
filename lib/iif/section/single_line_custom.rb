module IIF
  module Section
    class SingleLineCustom < Base
      def string_process
        super
        header = sanitize_header(scanner.scan_until(/^\!.*\r\n/))
        key = header.keys.first
        key_without_bang = key.to_s.lchomp('!')
        _ = scanner.scan_until(/^\!END#{key_without_bang}.*\r\n/) # discard end header line
        lines = []

        while !scanner.eos?
          match = scanner.scan_until(/#{key}.*\r\n/)
          if match[/^END#{key_without_bang}/]
            break
          else
            lines << match
          end
        end

        {header: header, body: body(lines)}
      end
    end
  end
end
