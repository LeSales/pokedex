searchByName(String name) {
  return '''
query ByName {
  pokemon_v2_pokemon(where: {name: {_regex: "$name"}}, limit: 10) {
    name
    id
    height
    weight
    pokemon_v2_pokemontypes {
      pokemon_v2_type {
        name
      }
    }
  }
}
''';
}

//GraphQL api non oficial site: https://graphql-pokeapi.vercel.app/
searchByNameNonOficial(String name) {
  return '''
query pokemon($name: String!) {
  pokemon(name: $name) {
    id
    name
    sprites {
      front_default
    }
    moves {
      move {
        name
      }
    }
    types {
      type {
        name
      }
    }
  }
}
''';
}

const gen1 = '''
  query samplePokeAPIquery {
  # Gets all the pokemon belonging to generation 1
  generation: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-i"}}}, order_by: {id: asc}) {
    name
    id
  }
  # You can run multiple queries at the same time
  # Counts how many pokemon where release for each generation
  generations: pokemon_v2_generation {
    name
    pokemon_species: pokemon_v2_pokemonspecies_aggregate {
      aggregate {
        count
      }
    }
  }
}
  ''';
