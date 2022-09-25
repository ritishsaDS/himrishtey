import 'package:flutter/material.dart';

class ItemInfoWidget extends StatefulWidget{
  @override
  State<ItemInfoWidget> createState() => _ItemInfoWidgetState();
}

class _ItemInfoWidgetState extends State<ItemInfoWidget> {
  List<String> myProducts=[
    "Document","Food","Daily necessities","Clothing","Digital Product","Other"
  ];
int ?selectItem=0;
  @override
  Widget build(BuildContext context) {
    return Container(child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,

            childAspectRatio: 8 / 2.5,
            crossAxisSpacing: 5,
            mainAxisSpacing: 15),
        itemCount: myProducts.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
              onTap: (){
                selectItem=index;
                setState(() {

                });
              },
              child: infoTile(title: myProducts[index],index: index));
        }),);
  }

Widget infoTile({String?title,int?index}){
    return  Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color:selectItem==index?Color(0xff0360fe): Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15)),
      child: Text(title!,style: TextStyle(color: selectItem==index?Colors.white: Color(0xff0a0731),fontSize: 12),),
    );
}
}