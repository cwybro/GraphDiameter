# Tool to create graphs

def createPath(size)
  puts "Creating path of size: #{size}"
  name = "path_#{size}.txt"
  File.open(name, 'w') { |f|
    f.write("#{size}\n")
    0.upto(size.to_i-1).each { |x| f.write("#{x} #{x+1}\n") }
  }
end

def createGraph(size)
  puts "Creating graph of size: #{size}"
  name = "graph_#{size}.txt"
  File.open(name, 'w') { |f|
    f.write("#{size}\n")
    0.upto(size.to_i-1).each { |x|
      # Each vertex connects to itself and next one in sequence
      f.write("#{x} #{x}\n")
      f.write("#{x} #{x+1}\n")
    }
  }
end

def createMaxGraph(size)
  puts "Creating maximally connected graph of size: #{size}"
  name = "graph_max_#{size}.txt"
  File.open(name, 'w') { |f|
    f.write("#{size}\n")
    0.upto(size.to_i-1).each { |x|
      0.upto(size.to_i-1).each { |y|
        f.write("#{x} #{y}\n")
      }
    }
  }
end

size = ARGV.length == 0 ? 10 : ARGV[0]
type = (ARGV.length == 1 || ARGV[1] != "graph") ? "path" : ARGV[1]
if ARGV[1] == "max"
  createMaxGraph(size)
else
  type == "path" ? createPath(size) : createGraph(size)
end
