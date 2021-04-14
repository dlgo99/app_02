import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
      //home: VideoPlayerScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage() : super();
  //HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  var infoText = "Coloque os valores!";
  var login = TextEditingController();
  var senha = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  VideoPlayerController _controller1;
  VideoPlayerController _controller2;
  Future<void> _initializeVideoPlayerFuture;


  void initState() {
    //_controller = VideoPlayerController.network
     //("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4");

    _controller1 = VideoPlayerController.asset("assets/videos/xuxa.mp4");
    _controller2 = VideoPlayerController.asset("assets/videos/contando.mp4");

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller1.initialize();
    _initializeVideoPlayerFuture = _controller2.initialize();

    _controller1.setLooping(true);
    _controller1.setVolume(1.0);
    _controller2.setLooping(true);
    _controller2.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("APP Educativo"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    login.text = "";
    senha.text = "";
    setState(() {
      infoText = "Digite os Valores:";
      _formKey = GlobalKey<FormState>();
    });
  }

  _img(var imagem){
    return Image.asset(
     imagem,
  //    width: 100,
     // height: 100,
      fit: BoxFit.fill,
    );
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(100.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _img ('assets/images/mortarboard256.png'),
              _textInfo3("Login:"),
              _editLogin("Login", login),
              _textInfo3("Senha:"),
              _editSenha("Senha", senha),
              RaisedButton(
                color: Colors.green,
                child:
                Text(
                  "Acessar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                onPressed: () {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      print("logado");
                      _resetFields();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => menuPrincipal()
                            ),
                          );
                    });
                  }
                },
              ),
            ],
          ),
        ));
  }

  menuPrincipal(){
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Principal"),
        centerTitle: true,
        actions: <Widget>[
        ],
      ),
      body: Center(
        child: Column(
            children: <Widget>[
            IconButton(
              icon: Image.asset('assets/images/book128.png'),
              iconSize: 300,
              onPressed: () {
                print("alfabeto clicado");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => menuAlfabeto()
                  ),
                );
              },
            ),
              IconButton(
                icon: Image.asset('assets/images/numbers128.png'),
                iconSize: 300,
                onPressed: () {
                  print("numeros clicado");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => menuNumeros()
                    ),
                  );
                },
              ),
      ],
        ),
      ),
    );
  }

  menuAlfabeto(){
    return Scaffold(
      appBar: AppBar(
        title: Text("Alfabeto"),
        centerTitle: true,
        actions: <Widget>[
        ],
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return
              AspectRatio(
              aspectRatio: _controller1.value.aspectRatio,
              //aspectRatio: 16 / 9,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller1),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller1.value.isPlaying) {
              _controller1.pause();
            } else {
              // If the video is paused, play it.
              _controller1.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller1.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),

    );
  }

  menuNumeros(){
    return Scaffold(
      appBar: AppBar(
        title: Text("Aprendendo a contar"),
        centerTitle: true,
        actions: <Widget>[
        ],
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return
              AspectRatio(
                aspectRatio: _controller2.value.aspectRatio,
                //aspectRatio: 16 / 9,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller2),
              );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller2.value.isPlaying) {
              _controller2.pause();
            } else {
              // If the video is paused, play it.
              _controller2.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller2.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  _bodyVideo(){

  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  _editLogin(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.name,
      enableSuggestions: false,
      autocorrect: false,
      style: TextStyle(
        fontSize: 22,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  _editSenha(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      enableSuggestions: false,
      autocorrect: false,
      obscureText: true,
      style: TextStyle(
        fontSize: 22,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      infoText = "nenhum valor inserido";
      return "Digite $field";
    }
    return null;
  }

  // // Widget text
  _textInfo(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 25.0),
    );
  }

  _textInfo2(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
    );
  }

  _textInfo3(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green, fontSize: 25.0),
    );
  }

}