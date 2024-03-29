import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SupplierOrderModel extends StatelessWidget {
  final dynamic order;
  const SupplierOrderModel({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.purple),
            borderRadius: BorderRadius.circular(15)),
        child: ExpansionTile(
          title: Container(
            constraints: const BoxConstraints(maxHeight: 80),
            width: double.infinity,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: Container(
                    constraints:
                        const BoxConstraints(maxHeight: 80, maxWidth: 80),
                    child: Image.network(order['orderimage']),
                  ),
                ),
                Flexible(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['odername'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(('Ksh ') +
                              (order['orderprice'].toStringAsFixed(2))),
                          Text(('x ') + (order['orderqty'].toString()))
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('see more..'),
              Text(order['deliverystatus']),
            ],
          ),
          children: [
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ('Name: ') + (order['custname']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        ('Phone No: ') + (order['phone']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        ('Email Address: ') + (order['email']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        ('Address: ') + (order['address']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Row(
                        children: [
                          const Text(
                            ('Payment Status: '),
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            (order['paymentstaus']),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.green),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            ('Delivery Status: '),
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            (order['deliverystatus']),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            ('Order Date: '),
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            (DateFormat('yyyy-MM-dd')
                                .format(order['orderdate'].toDate())
                                .toString()),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.green),
                          ),
                        ],
                      ),
                      order['deliverystatus'] == 'delivered'
                          ? const Text('This order has been already delivered!')
                          : Row(
                              children: [
                                const Text(
                                  ('Change Delivery State To: '),
                                  style: TextStyle(fontSize: 15),
                                ),
                                order['deliverystatus'] == 'preparing'
                                    ? TextButton(
                                        onPressed: () {
                                          DatePicker.showDatePicker(context,
                                              minTime: DateTime.now(),
                                              maxTime: DateTime.now().add(
                                                  const Duration(days: 365)),
                                              onConfirm: (date) async {
                                            await FirebaseFirestore.instance
                                                .collection('orders')
                                                .doc(order['orderid'])
                                                .update({
                                              'deliverystatus': 'transporting',
                                              'deliverydate': date,
                                            });
                                          });
                                        },
                                        child: const Text('transporting ?'))
                                    : TextButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('orders')
                                              .doc(order['orderid'])
                                              .update({
                                            'deliverystatus': 'delivered',
                                          });
                                        },
                                        child: const Text('delivered ?'))
                              ],
                            ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
