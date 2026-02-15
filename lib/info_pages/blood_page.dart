import 'custom/CustomButton.dart';
import 'custom/custom_page.dart';
import 'package:flutter/material.dart';

class BloodPage extends StatefulWidget {
  const BloodPage({super.key});

  @override
  State<BloodPage> createState() => _BloodPageState();
}

class _BloodPageState extends State<BloodPage> {
  List<String> bloodgroup=["A+","A-","B+","B-","O+","O-","AB+","AB-"];
  late List<bool>  selected=List.filled(bloodgroup.length, false);
  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
        child: Column(
          children: [
            CustomPage(
              text: "What's your blood group?",
              des: "Let's get to know your blood group.",
              number: 4,
            ),
            SizedBox(height: hei * .01),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 70
                ),
                itemCount: bloodgroup.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      selected[index]=!selected[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          border: BoxBorder.all(color:selected[index]? Color(0xff2563eb): Colors.grey,width: selected[index]?3:1,),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        width: wid * .25,
                        height: hei * .09,
                        child: Center(
                          child: Text(
                            bloodgroup[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomButton(onTap: () {},text: "Countinue"),
          ],
        ),
      ),
    );
  }
}
