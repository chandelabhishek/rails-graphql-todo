def create_mutation_query(input:)
  <<~GQL
    mutation {
      createTask( input: { #{input} } ) {
        task {
          id
          name
          description
        }
      }
    }
  GQL
end

def default_input
  name = 'Conquer Mordor'
  description = 'The fellowship need to reach mount doom'
  %(name: "#{name}", description: "#{description}")
end

def create_task(input = default_input)
  post '/graphql', params: { query: create_mutation_query(input: input) }
  json = JSON.parse(response.body)
  json_data = json['data']
  json_data ? json_data['createTask'] : json
end
