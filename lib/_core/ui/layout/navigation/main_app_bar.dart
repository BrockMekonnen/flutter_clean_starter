import 'package:clean_flutter/_core/ui/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MainAppBar extends AppBar with PreferredSizeWidget {
  MainAppBar({Key? key, Widget? title, required BuildContext context})
      : super(
            key: key,
            title: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 40,
              child: Container(
                width: ResponsiveValue<double>(context,
                    defaultValue: 250,
                    valueWhen: [
                      const Condition.equals(name: MOBILE, value: 400.0),
                      const Condition.equals(name: TABLET, value: 500.0),
                      const Condition.equals(name: DESKTOP, value: 540.0),
                    ]).value,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {},
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none)),
              ),
            ),
            actions: <Widget>[
              const SizedBox(
                width: 20,
              ),
              buildProfileMenu(context),
              const SizedBox(
                width: 20,
              )
            ],
            elevation: 1);
}

PopupMenuButton buildProfileMenu(BuildContext context) {
    return PopupMenuButton(
    offset: const Offset(0, 50), // SET THE (X,Y) POSITION
    iconSize: 30,
    icon: CircleAvatar(
      backgroundColor: Colors.white,
      child: Image.asset('assets/images/logo.png'),
    ),
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          enabled: false, // DISABLED THIS ITEM
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 320,
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            FlutterLogo(size: 42.0),
                            SizedBox(
                              width: 30,
                            ),
                            Text("Clean Flutter"),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 160,
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(250, 50)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () async {
                        final authBloc = BlocProvider.of<AuthBloc>(context);
                        authBloc.add(UserLoggedOut());
                      },
                      icon: const Icon(
                        Icons.login,
                        size: 18,
                      ),
                      label: const Text("LOGOUT"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
     
      ];
    },
  );

}
