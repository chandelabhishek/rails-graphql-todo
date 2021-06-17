module Mutations
  class UpdateTask < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :description, String, required: false
    argument :status, Boolean, required: false

    field :task, Types::TaskType, null: true
    field :errors, [String], null: false

    def resolve(id:, name: nil, description: nil, status: nil)
      task = Task.find(id)
      task.name = name unless name.nil?
      task.description = description unless description.nil?
      task.status = status unless status.nil?

      if task.save
        { task: task, errors: [] }
      else
        { task: nil, errors: user.errors.full_messages }
      end
    end
  end
end
