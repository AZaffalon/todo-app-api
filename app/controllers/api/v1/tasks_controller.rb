module Api
    module V1
        class TasksController < ApplicationController

            def index
                @tasks = Task.all
                render json: {status: 200, message: 'Loaded tasks', data: @tasks}, status: :ok
            end

            def create
                @task = Task.new(task_params)

                if @task.save
                    render json: {status: 200, message: 'Task created', data: @task}, status: :ok
                else
                    render json: {status: 400, message: 'Task not created', data: @task.errors}, status: :unprocessable_entity
                end
            end

            def update
                @task = Task.find(params[:id])

                if @task.update!(task_params)
                    render json: {status: 200, message: 'Task updated', data: @task}, status: :ok
                else
                    render json: {status: 400, message: 'Task not updated', data: @task.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                @task = Task.find(params[:id])
                @task.destroy

                render json: {status: 200, message: 'Task destroyed', data: @task}, status: :ok
            end

            private

            def task_params
                params.permit(:title, :completed)
            end

        end
    end
end