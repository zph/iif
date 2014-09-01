# module IIF
#   module Section
#     class TRNS
#       include Anima.new(:content)

#       def self.call(content)
#         p = new(content: content)
#         components = p.parse(content)
#         transacts = p.clean_transactions(components[:transactions])
#         header = p.clean_headers(components[:header])
#         tr = transacts.map { |t| p.attach_key_to_values(t, header) }
#       end

#       def is_transactions_only?
#         #TODO: check that we only have a single type in file
#         # if row.length == 1 & row.first != key
#         #   raise(ArgumentError, "file contains more than just TRNS items")
#         # end
#       end

#       def parse(content)
#         txt = StringScanner.new(content.strip)
#         header = txt.scan_until(/\!ENDTRNS/)

#         transactions = []
#         while !txt.eos?
#           transactions << txt.scan_until(/ENDTRNS/)
#           # break if txt.rest == "\r\n"
#         end

#         {header: header, transactions: transactions}

#       end

#       def clean_headers(heads)
#         normalize_rows(Array(heads), "!ENDTRNS").first.each_with_object({}) do |row, obj|
#           row = row.map(&:to_sym)
#           obj[row.first.to_s.gsub(/^\!/, '').to_sym] = row[1..-1]
#         end
#       end

#       def clean_transactions(trans)
#         key = "ENDTRNS"
#         row = normalize_rows(trans, key)
#       end

#       def normalize_rows(rows, end_stub)
#         rows.map do |row|
#           row.strip
#           .split("\r\n")
#           .reject { |i| i == end_stub }
#           .map { |r| r.split("\t") }
#         end
#       end

#       def attach_key_to_values(transaction, header)
#         transaction.each_with_object({}) do |row, obj|
#           column_headers = header[row.first.to_sym].map(&:downcase)
#           values = row[1..-1]
#           hsh = column_headers.zip(values)
#           obj[row.first.downcase.to_sym] = Hash[hsh]
#         end
#       end

#     end
#   end
# end
