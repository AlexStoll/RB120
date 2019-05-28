# 3 available spaces
# when full, new item replaces oldest item
# when removing, remove oldest item
# maybe a hash, key is age, value is object itself

# class CircularQueue
#   def initialize(limit)
#     @limit = limit
#     @queue = Hash.new
#     @age = 0
#   end

#   def enqueue(item)
#     if @queue.size < @limit
#       @queue[@age += 1] = item
#     else
#       @queue.delete(@queue.keys.min)
#       @age += 1
#       @queue[@age] = item
#     end
#   end

#   def dequeue
#     @queue.delete(@queue.keys.min)
#   end
# end

class CircularQueue
  def initialize(limit)
    @limit = limit
    @queue = []
  end

  def enqueue(item)
    if @queue.size < @limit
      @queue << item
    else
      @queue.shift
      @queue << item
    end
  end

  def dequeue
    @queue.shift
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(false)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == false
puts queue.dequeue == nil
