module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :tasks, [Types::TaskType], null: false
    field :task, TaskType, null: false do
      argument :id, ID, required: true
    end

    field :tasks_with_status, [Types::TaskType], null: false do
      argument :status, Boolean, required: false
    end

    def tasks
      Task.all
    end

    def task(id:)
      Task.find(id)
    end

    def tasks_with_status(status: nil)
      Task.where(status: status)
    end
  end
end
