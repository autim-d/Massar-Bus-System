import 'app_colors.dart';
import 'package:flutter/material.dart';
import 'profile.dart';

class Acount extends StatelessWidget {
  const Acount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'الصفحة الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.percent),
            label: 'ترويج',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_outlined),
            label: 'تذكاري',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'الحساب',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset('assets/h.jpg',width: 400,),
              Positioned(
                bottom: -350,
                left: 0,
                right: 0,
                top: 45,

                child: SizedBox(
                  height: 460,
                  width: 340,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'خليل ابراهيم سيلان',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textSave
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'khalil@gmail.com',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textSave
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/defulte.jpg'),
                              radius: 30,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 29),
                      SizedBox(
                        height: 320,
                        width: 300,
                        child: Column(
                          children: [
                            Container(
                              height: 111,
                              width: 300,
                              decoration: BoxDecoration(
                                color: AppColors.cardColor,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: AppColors.iconOf,
                                  width: 0.2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (builder) => Profile(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            ' حسابي ',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 7),
                                        SizedBox(
                                          width: 240,
                                          child: Divider(
                                            height: 4,
                                            color: const Color.fromARGB(94, 102, 112, 133),
                                          ),
                                        ),
                                        SizedBox(height: 7),
                                        Text(
                                          ' حفظ الموقع ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 7),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                              height: 165,
                              width: 300,
                              decoration: BoxDecoration(
                                color: AppColors.cardColor,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: AppColors.iconOf,
                                  width: 0.2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 7),

                                        Text(
                                          ' الدعم والمساعدة ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        SizedBox(
                                          width: 240,
                                          child: Divider(
                                            thickness: 1,
                                            color: const Color.fromARGB(
                                              92,
                                              102,
                                              112,
                                              133,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '  أخبرنا بتجربتك مع التطبيق ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        SizedBox(
                                          width: 240,
                                          child: Divider(
                                            height: 2,

                                            color: const Color.fromARGB(
                                              80,
                                              102,
                                              112,
                                              133,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          ' الاعدادات  ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ==== Options Section ====
              // Expanded(
              //   child: SingleChildScrollView(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 20,
              //       vertical: 20,
              //     ),
              //     child: Column(
              //       children: [
              //         Container(
              //           decoration: BoxDecoration(
              //             borderRadius:BorderRadius.circular(10),
              //             boxShadow: [
              //               BoxShadow(
              //                 blurRadius: 2,
              //                 spreadRadius: 2,
              //                 offset: Offset(1, 2)
              //               )
              //             ]
              //           ),
              //           child: _buildCard([
              //             _buildListTile('حسابي'),
              //             _buildListTile('حفظ الموقع'),
              //           ]),
              //         ),
              //         const SizedBox(height: 12),
              //         _buildCard([
              //           _buildListTile('الدعم والمساعدة'),
              //           _buildListTile('أخبرنا بتجربتك مع التطبيق'),
              //           _buildListTile('الإعدادات'),
              //         ]),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  //   Widget _buildCard(List<Widget> children) {
  //     return Container(
  //       decoration: BoxDecoration(
  //         color: AppColors.textSave,
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.shade200,
  //             blurRadius: 8,
  //             offset: const Offset(0, 3),
  //           ),
  //         ],
  //       ),
  //       child: Column(children: children),
  //     );
  //   }

  //   Widget _buildListTile(String title) {
  //     return Column(
  //       children: [
  //         ListTile(
  //           title: Text(
  //             title,
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //           ),
  //           onTap: () {},
  //         ),
  //         if (title != 'الإعدادات') const Divider(height: 1),
  //       ],
  //     );
  //   }
}
