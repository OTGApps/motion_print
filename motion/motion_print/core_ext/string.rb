class String
  def shellescape
    "'" << self.gsub("'", "'\"'\"'") << "'"
  end
end
