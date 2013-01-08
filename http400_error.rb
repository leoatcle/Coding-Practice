class Http400Error < StandardError
  def message
    "Bad Request."
  end
end