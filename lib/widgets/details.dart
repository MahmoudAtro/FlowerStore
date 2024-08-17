// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:storeapp/layouts/pagelayout.dart';
// ignore: must_be_immutable
class Details extends StatefulWidget {
  Details({super.key, required this.product,});

  @override
  State<Details> createState() => _DetailsState();
  Map product;
}

class _DetailsState extends State<Details> {
  // const Details({Key? key}) : super(key: key);
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return Pagelayout(
    isbasket: false,
    icon: Icons.shopping_bag_rounded,  
    title: "Details",
    body: SingleChildScrollView(
      padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image.network("${widget.product["img"]}"),
              SizedBox(
                height: 11,
              ),
              Text(
                "${widget.product["name"]}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        "New",
                        style: TextStyle(fontSize: 15),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 129, 129),
                        borderRadius: BorderRadius.circular(4),
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 26,
                        color: Color.fromARGB(255, 255, 191, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 26,
                        color: Color.fromARGB(255, 255, 191, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 26,
                        color: Color.fromARGB(255, 255, 191, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 26,
                        color: Color.fromARGB(255, 255, 191, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 26,
                        color: Color.fromARGB(255, 255, 191, 0),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 38,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit_location,
                        size: 26,
                        color: Color.fromARGB(168, 3, 65, 27),
                        // color: Color.fromARGB(255, 186, 30, 30),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Flower Shop",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Details : ",
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). The biological function of a flower is to facilitate reproduction, usually by providing a mechanism for the union of sperm with eggs. Flowers may facilitate outcrossing (fusion of sperm and eggs from different individuals in a population) resulting from cross-pollination or allow selfing (fusion of sperm and egg from the same flower) when self-pollination occurs.",
                style: TextStyle(
                  fontSize: 18,
                ),
                maxLines: isShowMore ? 3 : null,
                overflow: TextOverflow.fade,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isShowMore = !isShowMore;
                    });
                  },
                  child: Text(
                    isShowMore ? "Show more" : "Show less",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ))
            ],
          ),
        ),
    isdrawer: false
    );
  }
}