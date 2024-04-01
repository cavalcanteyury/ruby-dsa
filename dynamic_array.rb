#!/usr/bin/env ruby


class DynamicArray
  def initialize(capacity)
    @array = Array.new(capacity)
    @len = 0
    @capacity = capacity
  end

  def size()
    @len
  end

  def is_empty?()
    self.size() == 0
  end

  def get(index)
    @array[index]
  end

  def set(index, elem)
    @array[index] = elem
  end

  def add(elem)
    if self.size() >= @capacity
      @capacity = @capacity * 2

      @array[@capacity - 1] = nil

      @array[size] = elem
      @len += 1
    else
      @array[size] = elem
      @len += 1
    end
  end

  def remove_at(index)
    tmp_array = []

    @array.each_with_index do |elem, idx|
      if idx == index
        next
      else
        tmp_array.push(elem)
      end
    end

    @array = tmp_array
    @len -= 1
    @capacity -= 1
  end

  def remove(target_elem)
    @array.each_with_index do |elem, idx|
      if elem == target_elem
        self.remove_at(idx)
      end
    end
  end
end


darray = DynamicArray.new(2)
darray.add(1)
darray.add("hello")

# This add should double the Array capacity, as it reached the maximum
darray.add("world")

p darray.inspect

# => @array=[1, \"hello\", \"world\", nil], @len=3, @capacity=4>"

darray.remove_at(0)

p darray.inspect

# => @array=[\"hello\", \"world\", nil], @len=2, @capacity=3>"

darray.remove("world")

p darray.inspect

# => @array=[\"hello\", nil], @len=1, @capacity=2>"
