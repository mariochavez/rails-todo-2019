require "test_helper"

class TodoTest < ActiveSupport::TestCase
  test "is valid" do
    subject = Todo.new todo_params

    assert subject.valid?
  end

  test "is invalid" do
    subject = Todo.new todo_params(name: "")

    refute subject.valid?
    refute_empty subject.errors[:name]
  end

  def todo_params(attributes = {})
    {name: "Test todo"}.merge(attributes)
  end
end
