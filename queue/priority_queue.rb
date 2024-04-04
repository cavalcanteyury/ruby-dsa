#!/usr/bin/env ruby

class Element
  attr_accessor :data, :priority

  def initialize(data, priority = data)
    @data, @priority = data, priority
  end

  # [Element <=> Element]
  # spaceship operator:
  # a <=> b
  # if a lesser than b returns -1
  # if a greater than b = 1
  # if a equals b = 0
  # if a not comparable with b = nil
  def <=>(element)
    @priority <=> element.priority
  end
end

class PriorityQueue
  attr_accessor :elements

  def initialize(elements, heap_order = -1)
    @elements = elements
    @compare = lambda { |x, y| (x <=> y) == heap_order }
  end

  def last_index
    @elements.size - 1
  end

  def size
    @elements.size
  end

  def <<(element)
    @elements << element

    target_index = last_index
    parent_index = (target_index - 1) / 2

    while @compare.call(@elements[target_index], @elements[parent_index])
      swap(target_index, parent_index)

      target_index = parent_index
      parent_index = (target_index - 1) / 2
    end
  end

  def pop
    swap(0, last_index)

    @elements.pop

    target_index = 0
    left_index = (target_index * 2) + 1
    right_index = (target_index * 2) + 2

    while (
      left_index < size && @compare.call(@elements[left_index], @elements[target_index]) ||
      right_index < size && @compare.call(@elements[right_index], @elements[target_index])
    )
      smallest_index = if right_index >= size || @elements[left_index].data < @elements[right_index].data
                         left_index
                       else
                         right_index
                       end

      swap(target_index, smallest_index)

      target_index = smallest_index
      left_index = (target_index * 2) + 1
      right_index = (target_index * 2) + 2
    end
  end

  def swap(target_index, swap_index)
    @elements[target_index], @elements[swap_index] = @elements[swap_index], @elements[target_index]
  end

  def inspect
    res = []

    for el in @elements
      res.push(el.data)
    end

    res
  end
end


# Example usage
min_heap = []

min_heap << Element.new(5)
min_heap << Element.new(9)
min_heap << Element.new(7)
min_heap << Element.new(10)
min_heap << Element.new(13)
min_heap << Element.new(8)
min_heap << Element.new(11)

pqueue = PriorityQueue.new(min_heap)

p pqueue.inspect()

pqueue << Element.new(6)

p pqueue.inspect

pqueue.pop()
pqueue.pop()

p pqueue.inspect

pqueue.pop()
pqueue.pop()
pqueue.pop()

p pqueue.inspect
