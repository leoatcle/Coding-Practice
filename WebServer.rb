require 'socket'

begin
  server = TCPServer.new(ARGV[1])
rescue 
  puts "Invalid Argument."
  return
end

begin
  loop do
    client = server.accept  
    
    while line=client.gets
      puts line.chop
      break if line =~ /^\s*$/
    end
      
    client.puts "<html>"
    client.puts "<head>PATH OF CURRENT DIRECTORY: \t<br /></head><body>"
  
    Dir.glob("*").each do |f|
      client.puts "<a href='"+f+"'>"+f + "</a>\t" + File.stat(f).ctime.to_s+"<br />"
    end
  
    client.puts "</body></html>"
             
    client.close
  end
rescue => e
  puts e.message
  server = TCPServer.new(port)
  retry
end

