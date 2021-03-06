require 'json'
require 'uri'
require 'socket'
require_relative '../rule_engine'
require_relative '../visitors/configuration_visitor'
require_relative '../facades/configuration_page_facade'
require_relative '../facades/configuration_file_facade'

class LanguageServer

  def self.start(port)
    port ||= 5007
    server = TCPServer.open(port)

    loop {
      Thread.fork(server.accept) do |client|
        while line=client.gets
          length=Integer(line.scan(/\d/).join(''))
          line=client.read(length+2)
          request = JSON.parse(line)
          $logger.debug(line)

          method_name = request['method'].sub('/', '_')
          response = if self.respond_to? "client_"+method_name then self.send("client_"+method_name,request['id'],request['params']) end

          if not response.nil?
            client.flush
            client.print("Content-Length: "+response.length.to_s+"\r\n\r\n")
            client.print(response)
            $logger.debug(response)
          end
        end
        client.close
      end
    }
  end

  def self.client_initialize(id,params)
    return JSON.generate({
      jsonrpc: '2.0',
      result: {
        capabilities: {
          textDocumentSync:1,
          implementationProvider: "true"
        }
      },
      id: id
    })
  end

  def self.client_textDocument_didOpen(id,params)
    uri = params["textDocument"]["uri"]
    version = params["textDocument"]["version"]
    code = params['textDocument']['text']
    return self.generate_diagnostics(uri,version,code)
    return
  end

  def self.client_textDocument_didChange(id,params)
    uri = params["textDocument"]["uri"]
    version = params["textDocument"]["version"]
    code = params['contentChanges'][0]['text']
    return self.generate_diagnostics(uri,version,code)
    return
  end

  def self.generate_diagnostics(uri,version,code)
    result = RuleEngine.analyzeDocument(code) #convert to json

    diagnostics = []

    result.each do |sin|
      diagnostics.append({
                           range:{
                             start: { line: sin.begin_line-1, character: sin.begin_char },
                             end: { line: sin.end_line-1, character: sin.end_char }
                           },
                           severity: 2,
                           code: {
                             value:sin.type[:name],
                             target:sin.type[:solution]
                           },
                           source:'Puppet-sec-lint',
                           message: sin.type[:message]
                         })
    end

    return JSON.generate({
                           jsonrpc: '2.0',
                           method: 'textDocument/publishDiagnostics',
                           params: {
                             uri: uri,
                             version: version,
                             diagnostics: diagnostics
                           }
                         })
  end

end
