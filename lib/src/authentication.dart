// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:palominos/PantallaPrincipal.dart';

import 'widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: loggedIn,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width / 1.5, 50),
              ),
              onPressed: () {
                context.push('/principal');
              },
              child: const Text('Volver a la pantalla principal',
                  style: TextStyle(color: Colors.black, fontSize: 15))),
        ),
        SizedBox(height: 10), // new
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 50),
              ),
              onPressed: () {
                !loggedIn ? context.push('/sign-in') : signOut();
              },
              child: !loggedIn
                  ? const Text('Iniciar sesion',
                      style: TextStyle(color: Colors.black))
                  : const Text('Cerrar Sesion',
                      style: TextStyle(color: Colors.black))),
        ),
      ],
    );
  }
}
