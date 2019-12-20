class TodosController < ApplicationController
  def index
    @todos = Todo.order(created_at: :desc)
    @todo = Todo.new
  end

  def create
    todo = Todo.new(todo_params)

    if todo.save
      todo_html = render_to_string(partial: "todos/todo", locals: {todo: todo}, formats: [:html])
      return render(json: {id: todo.id, html: todo_html}, status: :created)
    end

    render json: {errors: todo.errors.to_h}, status: :unprocessable_entity
  end

  def update
    todo = Todo.find_by(id: params[:id])

    return render(plain: "", status: :no_content) if todo.update(todo_params)

    render json: {errors: todo.errors.to_h}, status: :unprocessable_entity
  end

  def destroy
    todo = Todo.find_by(id: params[:id])
    todo.destroy

    render plain: "", status: :no_content
  end

  private

  def todo_params
    params.require(:todo).permit(:name)
  end
end
