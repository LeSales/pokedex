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
