# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @test_stack = Stack.new
    @test_stack.push!('element_one')
    @test_stack.push!('element_two')
  end

  def test_push!
    @test_stack.push!('element_three')

    assert { @test_stack.to_a.last == 'element_three' }
  end

  def test_pop!
    popped_element = @test_stack.pop!

    assert { popped_element == 'element_two' }
    assert { @test_stack.to_a.last == 'element_one' }
  end

  def test_clear!
    @test_stack.clear!
    assert { @test_stack.to_a.empty? }
  end

  def test_empty?
    refute { @test_stack.to_a.empty? }

    @test_stack.clear!
    assert { @test_stack.to_a.empty? }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
