require 'rails_helper'
require 'util'

module Mutations
  RSpec.describe UpdateTask, type: :request do
    describe '.resolve' do
      context 'when name, description or status  are provided' do
        it 'updates an existing task' do
          id = create_task.dig('task', 'id')
          input = %(id: "#{id}", status: true)
          post '/graphql',
               params: { query: update_mutation(input: input) }
          json = JSON.parse(response.body)
          puts json
          data = json['data']['updateTask']
          expect(data.dig('task', 'id')).not_to be_empty
          expect(data.dig('task', 'status')).to eq true
        end
      end
    end

    def update_mutation(input: nil)
      <<~GQL
        mutation {
            updateTask( input: { #{input} } ) {
                task {
                    id
                    status
                }
            }
        }
      GQL
    end
  end
end

