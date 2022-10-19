import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/auth/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/blocs/post_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  List<Post> items = [];
  File? _image;
  User? user;
  int countPosts = 0;

  // for user image
  _imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  late PostBloc postBloc;
  late AuthBloc authBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postBloc = BlocProvider.of<PostBloc>(context)..add(const LoadPostsEvent());
    authBloc = BlocProvider.of<AuthBloc>(context)..add(LoadUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if(state is LoadPostsStateSuccess) {
          setState(() {
            items = state.posts;
          });
        }
      },
      builder: (context, state) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is LoadUserSuccessState) {
              setState(() {
                user = state.user;
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Billabong",
                      fontSize: 30),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        // widget.pageController!.jumpToPage(2);
                      },
                      icon: const Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ))
                ],
              ),
              body: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // #avatar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Colors.purpleAccent, width: 2)),
                                  padding: const EdgeInsets.all(2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(75),
                                    child: user?.imageUrl == null ||
                                        user!.imageUrl!.isEmpty
                                        ? const Image(
                                      image: AssetImage(
                                          "assets/images/user.png"),
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    )
                                        : Image(
                                      image: NetworkImage(user!.imageUrl!),
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 77.5,
                                  width: 77.5,
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: () {
                                          _showPicker(context);
                                        },
                                        icon: const Icon(
                                          Icons.add_circle,
                                          color: Colors.purple,
                                        )),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    text: "${items.length}\n",
                                    children: const [
                                      TextSpan(
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                        text: "POST",
                                      )
                                    ]),
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    text: user == null
                                        ? "0"
                                        : "${user!.followersCount}\n",
                                    children: const [
                                      TextSpan(
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                        text: "FOLLOWERS",
                                      )
                                    ]),
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    text: user == null
                                        ? "0"
                                        : "${user!.followingCount}\n",
                                    children: const [
                                      TextSpan(
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                        text: "FOLLOWING",
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // #name
                        Text(
                          user == null ? "" : user!.fullName.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),

                        // #email
                        Text(
                          user == null ? "" : user!.email,
                          style: const TextStyle(color: Colors
                              .black54, fontSize: 12),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        // #statistics

                        // #posts
                        Expanded(
                          child: Column(children: [

                            Row(children: [
                              Column(children: [Container(
                                height:70,width:70,
                                decoration:
                                BoxDecoration(borderRadius:
                                BorderRadius.circular(234234),
                                    border: Border.all(color:
                                    Colors.black,width: 2)),
                                child: const Icon(Icons.add,
                                  size: 30,),),
                              const SizedBox(height: 5,),

                              const Text('Add')],)

                            ],),
                            BottomNavigationBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,

                              items:
                            [
                              BottomNavigationBarItem(icon: Icon
                              (Icons.add),label: ''),BottomNavigationBarItem(icon: Icon
                              (Icons.add),label: ''),BottomNavigationBarItem(icon: Icon
                              (Icons.add),label: ''),
                            ],),
                          Expanded(
                            child: GridView.builder(
                            itemCount: items.length,
                              itemBuilder: (context, index) {
                                return itemOfPost(index, context);
                              }, gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,

                              ),),
                          ),],)
                        ),
                      ],
                    ),
                  ),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }

  InkWell itemOfPost(int index, BuildContext context) {
    return   InkWell(
      onLongPress: () {},
      child: CachedNetworkImage(
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        imageUrl: items[index].postImage,
        placeholder: (context, url) => Container(
          color: Colors.grey,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
