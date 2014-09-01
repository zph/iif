module IIF
  class Parser
    include Anima.new(:content)
    # Custom Section definitions end with !ENDCUSTOMSECTION and read until an ENDCUSTOMSECTION
    # Builtin sections:
    #   - if single line entries, first cell is the section name
    #   - if multiline entries, first cell identifies the type and they end with an ENDSECTION (ie ENDTRANS)

    def multi_line_header?(head)
      !!content[/^\!END#{head.lchomp('!')}\b/]
    end

    def single_line_header?(head)
      ! multi_line_header?(head)
    end

    def scanner
      @scanner ||= StringScanner.new(content)
    end

    def current_key(section)
      section.split("\t").first
    end

    def backup(inc = 1)
      scanner.pos -= inc
    end

    def sections
      scanner.reset

      sections = []
      while !scanner.eos?
        match = scanner.scan_until(/(.*\r\n)\!/)
        backup unless scanner.eos?
        if match
          #TODO: check if it's a multiline definition
          output = match.chomp('!')

          key = match.split("\t").first.lchomp('!')
          has_custom_definition = scanner.check_until(/\r\nEND#{key}/)
          if has_custom_definition
            output += scanner.scan_until(/\r\nEND#{key}.*\r\n/)
          end

          sections << output
        else
          sections << scanner.rest
          break
        end
      end

      sections.map(&:lstrip)
    end

    def custom_header?(section)
      key = current_key(section).lchomp('!')
      match = section[/!END#{key}/] && section[/\bEND#{key}\b/]
      ! match.nil?
    end

    def sanitize_sections
      sections.map do |section|
        sanitize_section(section)
      end
    end

    def sanitize_section(section)
      key = current_key(section)
      case
      when custom_header?(section)
        Section::SingleLineCustom.new(content: section).extract
      when multi_line_header?(key)
        Section::MultiLine.new(content: section).extract
      when single_line_header?(key)
        Section::SingleLine.new(content: section).extract
      else
        raise(ArgumentError, "Not yet implemented")
      end

    end
  end
end
