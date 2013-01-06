class StringParsing
  def parse_request_line(line)
    @method_list = ["OPTIONS", "GET", "HEAD", "POST", "PUT", "DELETE", "TRACE", "CONNECT"]
    if line.length>0
      p1 = line.split(" ")[0];
      p2 = line.split(" ")[1];
      p3 = line.split(" ")[2];
      
      if @method_list.include?(p1.upcase)
        @method = p1
      else
        puts :status => 400
        return
      end
      
      if p2.length>0
        if (p2.length==1 && (p2=="*" || p2=="/")) || (p2.length>1 && p2.split("")[0]=="/") || (p2.length>7 && p2[0,7].downcase=="http://")
          @path = p2;
        else
          puts :status => 400
          return
        end
      else
        puts :status => 400
        return
      end
      
      if p3.length>0
        if p3.split("/")[0].downcase=="http" && p3.split("/")[1]=="1.1"
          @version = p3.split("/")[1]
        else
          puts :status => 400
          return
        end
      else
        puts :status => 400
        return
      end
      
      puts :method => :"#{@method.upcase}", :path => @path, :version => @version
      return
    else
      puts :text => "Empty Request Line", :status => 400
      return
    end
  end
  
  def parse_request_line_reg(line)
    if line.length>0
      pattern = /(OPTIONS|GET|HEAD|POST|PUT|DELETE|TRACE|CONNECT)\s+\S+\s+HTTP\/\d.\d/
      if (pattern).match(line)
        @method = line.split(" ")[0];
        @path = line.split(" ")[1];
        @version = line.split(" ")[2].split("/")[1];
        puts :method => :"#{@method.upcase}", :path => @path, :version => @version
        return
      else
        puts :status => 400
        return
      end
      
      return
    else
      puts :text => "Empty Request Line", :status => 400
      return
    end
  end

end
