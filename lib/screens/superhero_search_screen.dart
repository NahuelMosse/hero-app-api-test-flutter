import 'package:flutter/material.dart';
import 'package:hero_app/data/model/superhero_respose.dart';
import 'package:hero_app/data/repository.dart';
import 'package:hero_app/components/superhero_detail_component.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> {
  Repository repository = Repository();
  Future<SuperheroRespose?>? _superheroResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca un superhéroe'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Busca un superhéroe',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _superheroResponse = repository.fetchSuperheroes(value);
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(future: _superheroResponse, builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData && snapshot.data!.results.isNotEmpty) {
                final results = snapshot.data!.results;
                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final superhero = results[index];
                    return SuperheroDetailComponent(superhero: superhero);
                  },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('No se encontraron resultados'),
                );
              }
            })
          )
        ],
      ),
    );
  }
}