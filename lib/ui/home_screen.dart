
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
import '../data/model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PostBloc postBloc;

  @override
  void initState() {
    postBloc = BlocProvider.of<PostBloc>(context);
    postBloc.add(FetchPostEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 35,
          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu-JxuDBGV26p7Q2Tq-3L9By2CGBrixYvtKg&usqp=CAU'),
        ),
        title: const Text("Coupinos Post Get", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 23),),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: const Icon(Icons.search, size: 30, color: Colors.black,)),
          const SizedBox(width: 8,),
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications, size: 30, color: Colors.black,)),
        ],
      ),
      body: Container(
        child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
          if (state is PostInitialState) {
            return _buildLoading();
          } else if (state is PostLoadingState) {
            return _buildLoading();
          } else if (state is PostLoadedState) {
            return _foodList(state.postedDetails);
          } else if (state is PostErrorState) {
            return _buildError();
          } else {
            throw Exception();
          }
        }),
      ),
    );
  }
}

//Widgets...
Widget _buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget _foodList(List<Post> postdetails) {
  return Container(
    child: ListView.builder(
        itemCount: postdetails.length,
        itemBuilder: (context, index) {
          var baseUrl = 'https://coupinos-app.azurewebsites.net';
          return Card(
            elevation: 5.0,
            child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: 90,
                      width: 100,
                      child: Image.network(baseUrl+'${postdetails[index].postedBy.profilePicUrl}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                                margin: EdgeInsets.only(top: 9),
                                child: Text("Name:- "+"${postdetails[index].postedBy.firstName}"+" "+"${postdetails[index].postedBy.lastName}",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                )),
                            SizedBox(height: 8,),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                postdetails[index].address,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                "Id:- "+"${postdetails[index].id}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                "User Id:- "+"${postdetails[index].postedBy.userId}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                "Date of Creation:- :- "+"${postdetails[index].createdAt.day}"+"/"+'${postdetails[index].createdAt.month}'+"/"+"${postdetails[index].createdAt.year}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Container(
                              padding: EdgeInsets.all(2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Status: " +'${postdetails[index].status}', style: TextStyle(fontSize: 14),),
                                  const SizedBox(width: 5,),
                                  const CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 5,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 8,),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                "Type:- "+"${postdetails[index].type}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ))
                  ],
                )),
          );
        }),
  );
}

Widget _buildError() {
  return Center(child: Text('No Data Available'));
}
