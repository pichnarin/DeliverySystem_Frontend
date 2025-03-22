import 'package:flutter/material.dart';

class LocationList extends StatefulWidget {
  final List<String> locations;
  final Function(List<String>) onChanged;

  const LocationList({Key? key, required this.locations, required this.onChanged}) : super(key: key);

  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  late List<String> _locations;

  @override
  void initState() {
    super.initState();
    _locations = List<String>.from(widget.locations);
  }

  void _addLocation() {
    setState(() {
      _locations.add('');
      widget.onChanged(_locations);
    });
  }

  void _removeLocation(int index) {
    setState(() {
      _locations.removeAt(index);
      widget.onChanged(_locations);
    });
  }

  void _updateLocation(int index, String value) {
    setState(() {
      _locations[index] = value;
      widget.onChanged(_locations);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _locations[index],
                      decoration: InputDecoration(
                        labelText: 'Location ${index + 1}',
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) => _updateLocation(index, value),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => _removeLocation(index),
                  ),
                ],
              ),
            );
          },
        ),
        TextButton(
          onPressed: _addLocation,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add),
              Text('Add Location'),
            ],
          ),
        ),
      ],
    );
  }
}

