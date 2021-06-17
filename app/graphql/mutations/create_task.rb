module Mutations
  class CreateTask < Mutations::BaseMutation
    argument :name, String, required: true
    argument :description, String, required: true
    argument :status, Boolean, required: false

    field :task, Types::TaskType, null: true
    field :errors, [String], null: false

    def resolve(name:, description:, status: nil)
      task = Task.new(name: name, description: description, status: status)
      if task.save
        { task: task, errors: [] }
      else
        { task: nil, errors: user.errors.full_messages }
      end
    end
  end
end
