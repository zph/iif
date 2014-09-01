module IIF
  module Section
    class SingleLine < Base
      def string_process
        super
        header = sanitize_header(scanner.scan_until(/^\!.*\r\n/))
        key = header.keys.first
        lines = []
        while !scanner.eos?
          lines << scanner.scan_until(/#{key}.*\r\n/)
        end

        {header: header, body: body(lines)}
      end
      # TODO: memoize
    end
  end
end
