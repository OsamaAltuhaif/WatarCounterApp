import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/water_provider.dart';

class AddWaterProccess extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.blue, blurRadius: 1, offset: Offset(1, 1))
          ],
        ),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'أدخل الكمية بالملليلتر'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: () {
                final quantity = int.tryParse(controller.text);
                if (quantity != null) {
                  Provider.of<WaterProvider>(context, listen: false)
                      .addEntry(quantity);
                  controller.text = "";
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تمت إضافة الكمية بنجاح')));
                }
              },
              child: Text(
                'إضافة',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
