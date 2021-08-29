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

const gen2 = '''
  query samplePokeAPIquery {
  # Gets all the pokemon belonging to generation 2
  generation: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-ii"}}}, order_by: {id: asc}) {
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

const gen3 = '''
  query samplePokeAPIquery {
  # Gets all the pokemon belonging to generation 3
  generation: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-iii"}}}, order_by: {id: asc}) {
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

const gen4 = '''
  query samplePokeAPIquery {
  # Gets all the pokemon belonging to generation 4
  generation: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-iv"}}}, order_by: {id: asc}) {
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

const gen5 = '''
  query samplePokeAPIquery {
  # Gets all the pokemon belonging to generation 5
  generation: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-v"}}}, order_by: {id: asc}) {
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

const gen6 = '''
  query samplePokeAPIquery {
  # Gets all the pokemon belonging to generation 6
  generation: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-vi"}}}, order_by: {id: asc}) {
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

const gen7 = '''
  query samplePokeAPIquery {
  # Gets all the pokemon belonging to generation 7
  generation: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-vii"}}}, order_by: {id: asc}) {
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

const gen8 = '''
  query samplePokeAPIquery {
  # Gets all the pokemon belonging to generation 8
  generation: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-viii"}}}, order_by: {id: asc}) {
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
