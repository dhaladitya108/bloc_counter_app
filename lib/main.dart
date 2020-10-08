import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
              if (state.isIncreated) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Incremented'),
                    duration: Duration(milliseconds: 300),
                  ),
                );
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Decremented'),
                  duration: Duration(milliseconds: 300),
                ));
              }
            }, builder: (context, state) {
              if (state.counterValue < 0) {
                return Text(
                  'Oh no it\'s negative' + state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              } else if (state.counterValue == 0) {
                return Text(
                  'It\'s zero bru',
                  style: Theme.of(context).textTheme.headline4,
                );
              } else if (state.counterValue == 5) {
                return Text(
                  'Yehaaa it\'s 5',
                  style: Theme.of(context).textTheme.headline4,
                );
              } else {
                return Text(state.counterValue.toString());
              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                    // context.bloc<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // BlocProvider.of<CounterCubit>(context).decrement();
                    context.bloc<CounterCubit>().increment();
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
