import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/home_controller.dart';
import 'package:flutter_project/domain/models/coupon.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_project/utils/confirm_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    void onItemTapped(int index) {
      ref.read(injectHomeController).setSelectedIndex(index);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () async {
                await ConfirmDialog().displayConfirmDialog(context, () async {
                  await ref.read(injectHomeController).logout();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/login", (_) => true);
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey,
        padding: const EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                  child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        "Cupons Pendentes",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ref.watch(listCupons).when(
                        data: (data) {
                          return data.value.isEmpty
                              ? const Text("Não existe Cupoms ")
                              : ValueListenableBuilder<List<Coupon>>(
                                  valueListenable: data,
                                  builder: (_, list, __) {
                                    return ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: list.length,
                                        separatorBuilder: (_, __) => const Divider(),
                                        itemBuilder: (_, i) => ListTile(
                                          leading: const Icon(Icons.file_open),
                                          title: Text("${list[i].id} - ${list[i].code}"),
                                          onTap: () {
                                            Navigator
                                                .of(context)
                                                .pushNamed(
                                                "/note",
                                                arguments: list[i]
                                            );
                                          },
                                        )
                                    );
                                  },
                                );
                        },
                        error: (error, stackTrace) =>
                            Text("$error $stackTrace"),
                        loading: () => Container(
                              padding: const EdgeInsets.all(20),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  Text("Carregando...")
                                ],
                              ),
                            ))
                  ],
                ),
              ))
            ]),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: ref
              .read(injectHomeController)
              .bottomMenuBar,
          builder: (_, i, __) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ],
            currentIndex: i,
            selectedItemColor: Colors.amber[800],
            onTap: onItemTapped,
          );
        }
      ),
    );
  }
}
