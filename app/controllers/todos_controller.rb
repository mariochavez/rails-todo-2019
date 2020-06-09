class TodosController < ApplicationController
  include CableReady::Broadcaster

  TODOS_CHANNEL = "todos"

  def index
    @todos = Todo.order(created_at: :desc)
    @todo = Todo.new
  end

  def create
    todo = Todo.new(todo_params)

    if todo.save
      cable_ready[TODOS_CHANNEL].insert_adjacent_html(
        selector: "#todo-list",
        position: "afterbegin",
        html: render_to_string(partial: "todos/todo", locals: {todo: todo}, formats: [:html])
      )
      cable_ready[TODOS_CHANNEL].set_value(
        selector: "#todo_name",
        value: ""
      )
      cable_ready[TODOS_CHANNEL].remove(
        selector: ".error"
      )
      cable_ready.broadcast

      return render(plain: "", status: :created)
    end

    cable_ready[TODOS_CHANNEL].insert_adjacent_html(
      selector: "#todo_name",
      position: "afterend",
      html: "<p class='error'>#{todo.errors[:name].first}</p>"
    )
    cable_ready.broadcast

    render json: {errors: todo.errors.to_h}, status: :unprocessable_entity
  end

  def destroy
    todo = Todo.find_by(id: params[:id])
    todo.destroy

    cable_ready[TODOS_CHANNEL].remove(selector: "##{ActionView::RecordIdentifier.dom_id(todo)}")
    cable_ready.broadcast

    render plain: "", status: :no_content
  end

  private

  def todo_params
    params.require(:todo).permit(:name)
  end
end
