class TodosController < ApplicationController
  def index
    @todos = Todo.order(created_at: :desc)
  end

  def create
    todo = Todo.new(todo_params)

    return render(json: {id: todo.id}, status: :created) if todo.save

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
