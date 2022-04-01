import 'dart:async';
import 'dart:convert';

import 'package:audioplayer/detailaudiopage.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayer/appcolor.dart' as AppColors;
import 'package:flutter/material.dart';
import 'mytabs.dart';
import 'package:audio_service/audio_service.dart';












class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  List? popularBooks;
  List? books;
  late ScrollController _scrollController;
  late TabController _tabController;
  ReadData() async {
    await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s){
      setState(() {
        popularBooks = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s){
      setState(() {
        books = json.decode(s);
      });
    });
  }


  int _currentPage = 0;
  late Timer _timer;
  PageController _pageController = PageController(
    initialPage: 0,
  );





  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }



  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();


    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(

        _currentPage,
        duration: Duration(milliseconds: 450),
        curve: Curves.easeIn,

      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,

      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(AssetImage("assets/menu.png"), size:24, color:Colors.black),
                    Row(
                      children: [
                        Icon(Icons.search,color: Colors.black,),
                        SizedBox(width: 10,),
                        Icon(Icons.notifications,color: Colors.black),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text("Popular Album", style: TextStyle(letterSpacing: 1.0,fontSize: 32,fontFamily: "RajdhaniMedium",color: Colors.black))

                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                  height: 180,
                  child: Stack(
                      children: [

                        Positioned(
                            top:0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 180,
                              child: PageView.builder(
                                  controller: _pageController,
                                  // PageController(viewportFraction: 0.8),
                                  itemCount: popularBooks==null?0:popularBooks?.length,
                                  itemBuilder: (_, i){
                                    return Container(
                                      height: 180,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(right: 10,left: 10),

                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          image:DecorationImage(
                                            image:AssetImage(popularBooks?[i]["img"]),
                                            fit:BoxFit.fill,
                                          )
                                      ),
                                    );
                                  }),
                            )
                        )
                      ]

                  )
              ),
              Expanded(child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll){

                  return[
                    SliverAppBar(

                      pinned: true,
                      backgroundColor:Colors.white,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20, left: 10),
                          child: TabBar(
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.only(right: 10),
                            controller: _tabController,
                            isScrollable: true,
                            indicator:  BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            // color:Colors.grey[300],
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                offset: Offset(0,0),
                                color:Colors.black.withOpacity(0.5),
                              )
                            ]
                        ),
                            tabs: [
                              AppTabs(color:AppColors.menu1Color, text:"New",),
                              AppTabs(color:AppColors.menu2Color, text:"Popular"),
                              AppTabs(color:AppColors.menu3Color, text:"Trending"),
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(


                  controller: _tabController,
                  children: [
                    Material(
                      color: Colors.white,

                      child: ListView.builder(

                          itemCount: books==null?0:books?.length,
                          itemBuilder: (_,i){
                            return
                              GestureDetector(
                                  onTap:(){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=>DetailAudioPage(booksData:books, index:i))
                                    );
                                  },

                                  child:Container(
                                    margin: const EdgeInsets.only(left:15, right: 15,top:10, bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color:Colors.grey[300],
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              offset: Offset(3, 3),
                                              color:Colors.grey.withOpacity(0.9),
                                            )
                                          ]
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: AssetImage(books?[i]["img"]),
                                                    fit: BoxFit.cover

                                                  )
                                              ),


                                                child: Icon(
                                                  Icons.play_circle_filled,
                                                  color: Colors.black.withOpacity(0.9),
                                                  size: 30.0,

                                                ),

                                            ),


                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Row(
                                                //   children: [
                                                //     Icon(Icons.star, size:24, color:AppColors.starColor),
                                                //     SizedBox(width: 5,),
                                                //     Text(books?[i]["rating"], style: TextStyle(
                                                //         color:AppColors.menu2Color
                                                //     ),),
                                                //   ],
                                                // ),
                                                Text(books?[i]["title"], style: TextStyle(fontSize: 22, fontFamily: "RajdhaniSemibold", ),),
                                                SizedBox(height: 2,),
                                                Text(books?[i]["text"], style: TextStyle(fontSize: 18, fontFamily: "RajdhaniMedium", color: Colors.deepPurple),),
                                                // Container(
                                                //   width: 60,
                                                //   height: 20,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius: BorderRadius.circular(3),
                                                //     color:AppColors.loveColor,
                                                //   ),
                                                //   // child:Text("Love", style: TextStyle(fontSize: 10, fontFamily: "Avenir", color:Colors.white),),
                                                //   alignment: Alignment.center,
                                                // )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              );
                          }),
                    ),
                    Material(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),

                    ),
                  ],

                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}