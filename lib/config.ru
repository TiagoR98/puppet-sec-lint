
app =
  Rack::Builder.new do |builder|
    builder.run LanguageServer.new
  end
handler.run app