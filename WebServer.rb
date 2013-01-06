require 'socket'

server = TCPServer.new(5000)
loop do
  client = server.accept
  client.print "PATH OF CURRENT DIRECTORY: \t"
  client.puts File.dirname(__FILE__)

  Dir.glob("*").each do |f|
    client.printf "%s \t %s \n", f, File.stat(f).ctime
  end
             
  while line=client.gets
    puts line.chop
    break if line =~ /^\s*$/
  end
  client.close
end

