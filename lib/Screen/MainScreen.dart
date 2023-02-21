import 'package:datepicker/Cubit/AppCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../Cubit/AppState.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final String output = 'Text';
  var datePicked;

  bool _isEven(DateTime date) {
    return date.day % 2 == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state is LoadedState) {
            return Container(
              color: Colors.blue,
              child: SizedBox.expand(
                child: Column(
                  children: [
                    SizedBox(height: 400),
                    TextButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          BlocProvider.of<AppCubit>(context).getDate(datePicked);
                        },
                        child: Text(
                          'Select a date',
                          style: TextStyle(color: Colors.black),
                        )),
                    SizedBox(
                      height: 200,
                    ),
                    Container(color: Colors.white,
                        padding: EdgeInsets.all(10), child: Text('Text')),
                  ],
                ),
              ),
            );
          }
          context.read<AppCubit>().getDate(datePicked);
          if (state is DateSelectedState) {
            return SizedBox.expand(
              child: Container(
                color: datePicked == null
                    ? Colors.blue
                    : _isEven(datePicked)
                        ? Colors.red
                        : Colors.yellow,
                child: Center(
                  child: Column(children: [
                    const SizedBox(height: 100),
                    IconButton(
                        color: Colors.white,
                        onPressed: () {
                          BlocProvider.of<AppCubit>(context).selected();
                        },
                        icon: Icon(Icons.exit_to_app)),
                    SizedBox(
                      height: 200,
                    ),
                    TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: () async {
                        DateTime? datePicker = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020, 1, 30),
                          lastDate: DateTime(2025, 12, 20),
                        );
                        //final cubit=context.read<AppCubit>();
                        if (datePicker != null) {
                            datePicked = datePicker;
                           // cubit.getDate(datePicked!);
                        }
                      },
                      child: Text(
                        datePicked == null
                            ? 'Select a date'
                            : 'Selected date: ${DateFormat('dd').format(datePicked)}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        datePicked == null
                            ? output
                            : 'Date is ${_isEven(datePicked) ? 'even' : 'odd'}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ]),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
