require "application_system_test_case"

class TodosTest < ApplicationSystemTestCase
  test "visit todos" do
    todos_count = Todo.count
    visit root_url

    assert_selector "h1", text: "Rails To Do".upcase
    assert_selector ".ToDoItem", count: todos_count
  end

  test "try to add an empty todo" do
    todos_count = Todo.count
    visit root_url

    fill_in "todo_name", with: ""
    click_button "+"

    assert_selector ".ToDoItem", count: todos_count
  end

  test "add a todo" do
    todo = "Add Tests"
    todos_count = Todo.count
    visit root_url

    fill_in "todo_name", with: todo
    click_button "+"

    assert_selector ".ToDoItem", count: todos_count + 1
    assert_selector ".ToDoItem", text: todo
  end

  test "delete a todo" do
    todo = todos(:todo)
    todos_count = Todo.count

    visit root_url
    todo_element = page.find ".ToDoItem", text: todo.name
    remove_button = todo_element.find ".ToDoItem-Delete"
    remove_button.click

    assert_selector ".ToDoItem", count: todos_count - 1
    refute_selector ".ToDoItem", text: todo.name
  end
end
