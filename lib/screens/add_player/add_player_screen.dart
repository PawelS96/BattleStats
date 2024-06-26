import 'dart:async';

import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/screens/add_player/add_player_event.dart';
import 'package:battlestats/screens/add_player/add_player_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlayerScreen extends StatefulWidget {
  final Function(Player) onAdded;
  final bool showKeyboard;

  const AddPlayerScreen({
    Key? key,
    required this.onAdded,
    this.showKeyboard = false,
  }) : super(key: key);

  @override
  State<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _node = FocusNode();

  var _platform = GamingPlatform.pc;
  var _validationMode = AutovalidateMode.disabled;

  late AddPlayerViewModel vm;

  late StreamSubscription<AddPlayerEvent> _eventsSub;

  @override
  void initState() {
    super.initState();
    vm = AddPlayerViewModel.of(context);
    _eventsSub = vm.events.listen(_handleEvent);

    if (widget.showKeyboard) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_node);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _node.dispose();
    _eventsSub.cancel();
    super.dispose();
  }

  void _handleEvent(AddPlayerEvent event) {
    switch (event) {
      case PlayerAdded():
        widget.onAdded(event.player);
        break;
      case PlayerAddError():
        _showError(event.message);
        break;
    }
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(message),
          backgroundColor: Colors.white,
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      child: Stack(
        children: [
          const BackgroundImage(),
          Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(),
            body: Consumer<AddPlayerViewModel>(
              builder: (ctx, vm, _) => SafeArea(
                top: false,
                child: Center(
                  child: vm.isLoading
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: LayoutBuilder(
                            builder: (ctx, constraints) {
                              return SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight,
                                    minWidth: constraints.maxWidth,
                                  ),
                                  child: IntrinsicHeight(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(height: 20),
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(maxWidth: 400),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                _playerNameTextField(),
                                                const SizedBox(height: 20),
                                                _platformSelector(),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 20),
                                            child: _okButton(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _playerNameTextField() {
    const borderRadius = 15.0;
    return Form(
      key: _formKey,
      autovalidateMode: _validationMode,
      child: TextFormField(
        controller: _nameController,
        focusNode: _node,
        validator: vm.validatePlayerName,
        onFieldSubmitted: (_) => _onConfirm(),
        style: const TextStyle(color: Colors.white, fontSize: 20),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          label: Text(
            'Your player name',
            style: TextStyle(color: Colors.white),
          ),
          contentPadding: EdgeInsets.all(24),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(color: Colors.white, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(color: Colors.white, width: 3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(color: Colors.red, width: 3),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(color: Colors.red, width: 3),
          ),
        ),
      ),
    );
  }

  Widget _okButton() {
    return MaterialButton(
      onPressed: _onConfirm,
      minWidth: 150,
      height: 50,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 3, color: Colors.white),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Text(
        'OK',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Widget _platformSelector() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var platform in GamingPlatform.values)
          MaterialButton(
            minWidth: 100,
            onPressed: () => setState(
              () {
                _platform = platform;
              },
            ),
            color: _platform == platform ? Colors.white : Colors.transparent,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              platform.displayedName,
              style: TextStyle(
                color: _platform == platform ? Colors.black : Colors.white,
              ),
            ),
          )
      ],
    );
  }

  void _onConfirm() {
    if (_formKey.currentState?.validate() == true) {
      final playerName = _nameController.text;
      vm.addPlayer(playerName, _platform);
    }

    if (_validationMode == AutovalidateMode.disabled) {
      setState(() {
        _validationMode = AutovalidateMode.onUserInteraction;
      });
    }
  }
}
