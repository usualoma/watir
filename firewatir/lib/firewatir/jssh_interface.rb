class JSSHInterface
  attr_reader :socket, :host, :port
  
  def initialize(host = "127.0.0.1", port = 9997)
    @host = host
    @port = port
    
    # Establish connection to browser
    connect
  end
  
  # This function creates a new socket at port 9997 and sets the default values for instance and class variables.
  # Raises a UnableToStartJSShException if cannot connect to jssh even after 3 tries.
  def connect(no_of_tries = 0)
    # JSSH listens on port 9997. Create a new socket to connect to port 9997.
    begin
      @socket = TCPSocket::new(@host, @port)
      @socket.sync = true
      read_socket()
    rescue
      no_of_tries += 1
      retry if no_of_tries < 3
      raise Watir::Exception::UnableToStartJSShException, "Unable to connect to machine : #{@host} on port #{@port}. Make sure that JSSh is properly installed and Firefox is running with '-jssh' option"
    end
  end
  private :connect
  
  # TODO: remove this
  def send(command, socket_flags=0)
    # Remove new lines applied during formatting
    command.gsub!("\n", "")
    # Terminating new line required to 'send' the command
    @socket.send("#{command}\n", socket_flags)
  end
  
  # Execute command and return result
  # TODO: handle error processing
  def execute(command)
    #puts "jssh_command is : #{jssh_command}"
    send(command)
    result = read_socket()
    return result
  end
  
  # Evaluate javascript and return result. Raise an exception if an error occurred.
  def js_eval(str)
    str.gsub!("\n", "")
    value = execute("#{str};\n")
    if md = /^(\w+)Error:(.*)$/.match(value) 
      eval "class JS#{md[1]}Error < StandardError\nend"
      raise (eval "JS#{md[1]}Error"), md[2]
    end
    value
  end
  
  #
  # Description:
  #  Reads the javascript execution result from the jssh socket. 
  #
  # Output: 
  # The javascript execution result as string.  
  #
  def read_socket()
    return_value = "" 
    data = ""
    receive = true
    #puts Thread.list
    s = nil
    while(s == nil) do
        s = Kernel.select([socket] , nil , nil, 1)
      end
      #if(s != nil)
      for stream in s[0]
        data = stream.recv(1024)
        #puts "data is : #{data}"
        while(receive)
          #while(data.length == 1024)
          return_value += data
          if(return_value.include?("\n> "))
            receive = false
          else    
            data = stream.recv(1024)
          end    
          #puts "return_value is : #{return_value}"
          #puts "data length is : #{data.length}"
        end
      end
      
      # If received data is less than 1024 characters or for last data 
      # we read in the above loop 
      #return_value += data
      
      # Get the command prompt inserted by JSSH
      #s = Kernel.select([socket] , nil , nil, 0.3)
      
      #if(s != nil)
      #    for stream in s[0]
      #        return_value += socket.recv(1024)
      #    end
      #end
      
      length = return_value.length 
      #puts "Return value before removing command prompt is : #{return_value}"
      
      #Remove the command prompt. Every result returned by JSSH has "\n> " at the end.
      if length <= 3 
        return_value = ""
      elsif(return_value[0..2] == "\n> ")    
        return_value = return_value[3..length-1]
      else    
        #return_value = return_value[0..length-3]
        return_value = return_value[0..length-4]
      end 
      #puts "Return value after removing command prompt is : #{return_value}"
      #socket.flush
      
      # make sure that command prompt doesn't get there.
      if(return_value[return_value.length - 3..return_value.length - 1] == "\n> ")
        return_value = return_value[0..return_value.length - 4]
      end    
      if(return_value[0..2] == "\n> ")
        return_value = return_value[3..return_value.length - 1]
      end   
      #puts "return value is : #{return_value}"
      return return_value
    end
    #private :read_socket
    
  end
