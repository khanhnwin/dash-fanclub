import 'package:flutter/material.dart';
import '../../api/api.dart';

class SingleOptionPicker<T extends SelectableOption> extends StatelessWidget {
  const SingleOptionPicker(
      {Key? key, required this.options, required this.setSingleOption})
      : super(key: key);

  final Map<T, int> options;
  final Function(T) setSingleOption;

  @override
  Widget build(BuildContext context) {
    return OptionsPicker<T>(
      options: options,
      setOption: (Set<T> options) => setSingleOption(options.first),
      allowsMultiple: false,
    );
  }
}

class OptionsPicker<T extends SelectableOption> extends StatefulWidget {
  const OptionsPicker(
      {required this.options,
      required this.setOption,
      this.allowsMultiple = false,
      Key? key})
      : super(key: key);

  final Map<T, int> options;
  final Function(Set<T>) setOption;
  final bool allowsMultiple;

  @override
  _OptionsPickerState<T> createState() => _OptionsPickerState<T>();
}

class _OptionsPickerState<T extends SelectableOption>
    extends State<OptionsPicker<T>> {
  // TODO: allow developers to pass in initial values
  late Set<int> _selectedOptions;
  late List<T> optionsList;

  @override
  void initState() {
    super.initState();
    // TODO: What if the first size has no inventory?
    _selectedOptions = <int>{0};
    optionsList = widget.options.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> textToggles = [];

    widget.options.forEach((T key, int quantity) {
      textToggles.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          color: key.color,
          child: Text(
            key.toString().toUpperCase(),
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      );
    });

    List<bool> _activeIndices = List.generate(
        optionsList.length, (int index) => _selectedOptions.contains(index));

    return ToggleButtons(
      children: textToggles,
      isSelected: _activeIndices,
      onPressed: (int index) {
        setState(() {
          if (!widget.allowsMultiple) {
            // Can't deselect an option by pressing it again
            if (_selectedOptions.contains(index)) {
              return;
            }
            _selectedOptions
              ..clear()
              ..add(index);
          } else {
            // If the item was previous selected, then
            if (_selectedOptions.contains(index)) {
              // we can remove it, unless it is the last one. Can't have an
              // empty button set.
              if (_selectedOptions.length > 1) {
                _selectedOptions.remove(index);
              }
            } else {
              // Of course, add a previously unselected button
              _selectedOptions.add(index);
            }
          }

          Set<T> _selectedOptionsNames = {};

          for (int index in _selectedOptions) {
            _selectedOptionsNames.add(optionsList[index]);
          }

          widget.setOption(_selectedOptionsNames);
        });
      },
    );
  }
}
