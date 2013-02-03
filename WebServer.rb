require 'socket'
require 'mime/types'

class WebServer
  
  def index
    begin
      unless ARGV.length==2 && ARGV[0]==="-p"
        puts "Invalid Argument."
        exit
      end
      server = TCPServer.new(ARGV[1])
    rescue => e
      puts e.message
      return
    end
    
    begin
      loop do
        client = server.accept  

        puts first_line = client.gets
        while line=client.gets
          puts line.chop
          break if line =~ /^\s*$/
        end
        
        if first_line.split(" ")[1]!="/"
          client.puts "Sorry, we don't serve <#{first_line.split(" ")[1].slice(1..-1)}> for now."
        else
          client.puts "<html>"
          client.puts "<head>PATH OF CURRENT DIRECTORY: \t<br /></head><body>"
          Dir.glob("*").each do |f|
            if WebServer.less_1024(f) #&& WebServer.is_text(f)
              client.puts "<a onclick='' href='"+f+"'>"+f + "</a>\t" + File.stat(f).ctime.to_s+"\t"+File.size("#{f}").to_s+"kb\t<br />"
            end
          end
          client.puts "</body></html>"
        end

        client.close
      end
    rescue => e
      puts e.message
      server = TCPServer.new(ARGV[1])
      retry
    end
  end
  
  def self.less_1024(file)
    return File.size("#{file}")<=1024
  end
  
  def self.is_text(file)
    return MIME::Types.type_for("#{file}").first=="text/plain"
  end
  
  def self.notification(file)
    return "Sorry, we don't server <"+file+"> for now."
  end
  
end
puts WebServer.new.index


