module HTTMultiParty::Multipartable
  DEFAULT_BOUNDARY = '-----------RubyMultipartPost'
  # prevent reinitialization of headers
  def initialize_http_header(initheader)
    super
    set_headers_for_body
  end

  def body=(value)
    # @body_parts = Array(value).map { |(k, v)| Parts::Part.new(boundary, k, v) }
    # @body_parts << Parts::EpiloguePart.new(boundary)
    @body_parts = value
    set_headers_for_body
  end

  def boundary
    DEFAULT_BOUNDARY
  end

  private

  def set_headers_for_body
    if defined?(@body_parts) && @body_parts
      # set_content_type('multipart/form-data',  'boundary' => boundary)
      # self.content_length = @body_parts.inject(0) { |sum, i| sum + i.length }
      # self.body_stream = CompositeReadIO.new(*@body_parts.map(&:to_io))
      self.content_length = @body_parts.length
      self.body_stream = CompositeReadIO.new(StringIO.new(@body_parts))
    end
  end
end
