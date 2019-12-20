require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  test "GET /todos" do
    get todos_path

    assert_response :success
  end

  test "POST /todos (success)" do
    post todos_path, params: {todo: {name: "Test todo"}}, as: :json

    assert_response :created

    json_response = JSON.parse(response.body, symbolize_names: true)
    assert json_response.dig(:id).present?
    assert json_response.dig(:html).present?
  end

  test "POST /todos (failure)" do
    post todos_path, params: {todo: {name: ""}}, as: :json

    assert_response :unprocessable_entity

    json_response = JSON.parse(response.body, symbolize_names: true)
    assert json_response.dig(:errors, :name).present?
  end

  test "PUT /todos/:id (success)" do
    todo = todos(:todo)
    put todo_path(todo), params: {todo: {name: "Test todo"}}, as: :json

    assert_response :no_content
  end

  test "PUT /todos/:id (failure)" do
    todo = todos(:todo)
    put todo_path(todo), params: {todo: {name: ""}}, as: :json

    assert_response :unprocessable_entity

    json_response = JSON.parse(response.body, symbolize_names: true)
    assert json_response.dig(:errors, :name).present?
  end

  test "DELETE /todos/:id" do
    todo = todos(:todo)

    delete todo_path(todo), as: :json

    assert_response :no_content
  end
end
