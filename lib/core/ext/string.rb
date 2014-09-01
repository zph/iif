class String
  def lchomp(char)
    self.gsub(/^#{char.shellescape}/, '')
  end

  def chomp_split
    self.chomp("\r\n").split("\t")
  end
end
