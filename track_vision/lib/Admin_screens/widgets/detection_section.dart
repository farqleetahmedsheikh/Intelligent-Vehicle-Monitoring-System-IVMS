import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/Admin_screens/widgets/detection_details.dart';
import 'package:track_vision/Auth/admin/detection_provider.dart';

import '../../utils/constant_colors.dart';

class DetectionSection extends ConsumerStatefulWidget{
  const DetectionSection({super.key});

  @override
  ConsumerState<DetectionSection> createState() => _DetectionSectionState();
}

class _DetectionSectionState extends ConsumerState<DetectionSection>{
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context){
    final detections = ref.watch(detectionProvider);

    return RefreshIndicator(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Real-time simulation button
          TextButton(onPressed: (){
            ref.read(detectionProvider.notifier).simulate();
            _listKey.currentState?.insertItem(0);
          }, child: const Text("Latest Detection", style: TextStyle(color: Colors.black,
          fontSize: 20, fontWeight: FontWeight.bold),)),
          const SizedBox(height: 10,),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.only(top: 10),
            child: AnimatedList(
            key: _listKey,
              initialItemCount: detections.length,
              itemBuilder: (context, index, animation){
              final detection = detections[index];
              return SizeTransition(
                  sizeFactor: animation,
              child: Dismissible(key: UniqueKey(), background: Container(color: Colors.red,),
                  onDismissed: (_){
                ref.read(detectionProvider.notifier).deleteDetection(index);
                AnimatedList.of(context).removeItem(index, (context, animation) => SizeTransition(
                    sizeFactor: animation,
                child: Container(),
                ));
                  },
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> DetectionDetailPage(detection),
                      )
                      );
                    },
                    child: ListTile(
                      leading:  Container(
                        decoration: BoxDecoration(
                          color: ConstantColors.accentBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.directions_car_outlined, size: 35, color: ConstantColors.textLightMode,)),
                      title: Row(
                        children: [
                          const Text("Plate: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          Text(detection.plate)
                        ],
                      ),
                      subtitle: Text(detection.timeAgo),
                    ),
                  )),
              );
              }),
          ),
        ],
      ),
        onRefresh: () async{
          await Future.delayed(const Duration(seconds: 1));
          ref.read(detectionProvider.notifier).clear();

        });
  }
}
