import 'package:agora_test/call.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(AgoraTest());

class AgoraTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Agora实例",
      home: AgoraTestBean(),
    );
  }
}

class AgoraTestBean extends StatefulWidget {
  @override
  _AgoraTestBeanState createState() => _AgoraTestBeanState();
}

class _AgoraTestBeanState extends State<AgoraTestBean> {
  final _inputController = new TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agora实例"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _inputController,
                        decoration: InputDecoration(
                            errorText: _validate ? "channel名称必须输入" : null,
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 2)),
                            hintText: "请输入channel名称"),
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 25,
                  color: Colors.white,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text('加入'),
                        onPressed: () => onJoin(),
                        color: Theme.of(context).accentColor,
                        textColor:
                            Theme.of(context).primaryTextTheme.button.color,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  onJoin() {
    print("我点击了加入");
    setState(() {
      _inputController.text.isEmpty ? _validate = true : _validate = false;
    });
    if (!_validate) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Call(channelName: _inputController.text)));
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
