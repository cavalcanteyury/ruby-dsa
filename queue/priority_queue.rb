#!/usr/bin/env ruby

# build PriorityQueue
# Insert into priority queue
# get min/max
# extract min/max
# clear
#

class Element
  attr_accessor :data, :priority

  def initialize(data, priority = data)
    @data, @priority = data, priority
  end

  def <=>(elem)
    @priority <=> elem.priority
  end
end

class PriorityQueue
  attr_accessor :elements

  def initialize(elements = [], order = -1)
    @elements = elements
    @compare = lambda { |left_el, right_el| (left_el <=> right_el) == order}
  end

  def <<(element)
    @elements << element

    target_index = @elements.size - 1
    parent_index = (target_index - 1) / 2

    while @compare.call(@elements[target_index], @elements[parent_index])
      swap(target_index, parent_index)

      target_index = parent_index

      parent_index = (target_index - 1) / 2
    end
  end

  def pop
    @elements[0], @elements[@elements.size - 1] = @elements[@elements.size - 1], @elements[0]

    @elements.pop

    target_index = 0
    left_index = 2 * target_index + 1
    right_index = 2 * target_index + 2

    while (left_index < @elements.size && @compare.call(@elements[left_index], @elements[target_index])) || (right_index < @elements.size && @compare.call(@elements[right_index], @elements[target_index]))
      smallest_index = if right_index >= @elements.size || @elements[left_index].data < @elements[right_index].data
                         left_index
                       else
                         right_index
                       end

      swap(target_index, smallest_index)

      target_index = smallest_index
      left_index = 2 * target_index + 1
      right_index = 2 * target_index + 2
    end
  end

  def swap(target_index, parent_index)
    @elements[parent_index], @elements[target_index] = @elements[target_index], @elements[parent_index]
  end

  def inspect
    res = []
    for el in @elements
      res.push(el.data)
    end

    res
  end

  # def pop
  #   last_el_index = @elements.size - 1
  #   @elements.sort!
  #   @elements.delete_at(last_el_index)
  # end
end

min_heap = []

min_heap << Element.new(4)
min_heap << Element.new(8)
min_heap << Element.new(6)
min_heap << Element.new(9)
min_heap << Element.new(12)
min_heap << Element.new(7)
min_heap << Element.new(10)

pq = PriorityQueue.new(min_heap)

p pq.inspect()

pq << Element.new(5)

p pq.inspect()

pq.pop()

p pq.inspect()

pq.pop()

p pq.inspect()

pq.pop()
pq.pop()
pq.pop()

p pq.inspect()
