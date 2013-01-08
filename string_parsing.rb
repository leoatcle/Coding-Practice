require './http400_error'
class StringParsing
  def parse_request_line(line)
    begin
       if !line.empty?
         request_line = line.split(" ");
         @method = request_line[0];
         @path = request_line[1];
         @version = request_line[2];

         if @method.upcase=="GET" && @path.start_with?("/") && @version.upcase=="HTTP/1.1"
           return :method => :"#{@method.upcase}", :path => @path, :version => @version.split("/")[1]
         else
           raise Http400Error
         end
       else
         raise Http400Error
       end
       
     rescue Http400Error => e
       return e.message
    end
  end
  
  def parse_request_line_reg(line)
    begin
      if line.length>0
        pattern = /GET\s+\/\S*\s+HTTP\/\d.\d/
        request_line = line.split(" ");
        @method = request_line[0];
        @path = request_line[1];
        @version = request_line[2];
        if (pattern).match(line)
          return :method => :"#{@method.upcase}", :path => @path, :version => @version.split("/")[1]
        else
          raise Http400Error
        end
      else
        raise Http400Error
      end
    
    rescue Http400Error => e
       return e.message
    end
  end

end

# StringParsing.new.parse_request_line("GE / HTTP/1.1")