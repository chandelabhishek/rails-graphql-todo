require 'rails_helper'
require 'util'

module Types
  RSpec.describe Task, type: :request do
    describe '.field' do
    
      it 'lists all tasks' do
        5.times do
          create_task
        end
        post '/graphql',
               params: { query: query_all }
        expect(JSON.parse(response.body)['data']['tasks'].length).to eq 5
      end

      it 'lists a task, when id is specified' do
        id = create_task.dig('task', 'id')
        post '/graphql',
               params: { query: query_one(id) }
        expect(JSON.parse(response.body)['data']['task']['id']).to eq id
      end

      it 'lists completed tasks' do
        3.times do
          create_task
        end

        4.times do
          create_task(%(name: "Conquer Mordor", description:"Frodo must destroy the ring", status: true))
        end
        post '/graphql',
               params: { query: query_with_status }
        expect(JSON.parse(response.body)['data']['tasksWithStatus'].length).to eq 4     
      end
    end

    def query_all
      <<~GQL
        query tasks {
          tasks {
              id
              name

              description
          }

        }
      GQL
    end

    def query_one(id)
      <<~GQL
        query {
            task(id: #{id}){
              id
              name
              description
            }
        }
      GQL
    end


    def query_with_status
        <<~GQL
          query {
            tasksWithStatus(status: true){
              id
              name
              description
            }
          }
        GQL
      end
  end
end
