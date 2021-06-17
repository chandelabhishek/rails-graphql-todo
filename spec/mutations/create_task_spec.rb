require 'rails_helper'
require 'util'
module Mutations
  RSpec.describe CreateTask, type: :request do
    describe '.resolve' do
      context 'when name, description are provided' do
        it 'creates a new task' do
          data = create_task
          expect(data.dig('task', 'id')).not_to be_empty
          expect(data.dig('task', 'name')).to eq 'Conquer Mordor'
          expect(data.dig('task', 'description')).to eq 'The fellowship need to reach mount doom'
        end
      end

      context 'when name or description are not provided' do
        it 'fails to create a new task' do
          resp = create_task(%(name: "Conquer Mordor"))
          data = resp['errors'][0]
          expect(data.dig('extensions', 'code')).to eq 'missingRequiredInputObjectAttribute'
        end
      end
    end
  end

end


