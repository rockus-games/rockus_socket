<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Простая библиотека для внедрения базового функционала WebSocket в ваше Flutter приложение

## Подключение

Подключите библиотеку добавив код в `pubspec.yaml` в раздел `dependencies`

```yaml
rockus_socket:
    git:
        url: https://github.com/rockus-games/rockus_socket.git
        ref: master
```

В результате должно получиться так:

```yaml
dependencies:
    flutter:
        sdk: "flutter"

    rockus_socket:
        git:
            url: https://github.com/rockus-games/rockus_socket.git
            ref: master

    # остальные ваши библиотеки и плагины
```

## Использование

Создайте объект класса `RSocket`

Используйте функцию `on` для чтения входящего события

```dart
RSocket socket = new RSocket({
    ip: "127.0.0.1:8080" // IP вашего сервера
})

void someEvent(Event event) {
    // Аргумент event имеет тип Event и содержит поля type и data

    print(event.type);
    print(event.data);
}

socket.on("название_события", someEvent);
```

Используйте off, offAll, offLast чтобы отключить чтение данного события

```dart
RSocket socket = new RSocket({
    ip: "127.0.0.1:8080" // IP вашего сервера
})

socket.off("название_события", someEvent);
//off требует обязательного указания функции, которую надо отключить

socket.offAll("название_события");
//offAll отключает все чтения для указанного события

socket.offLast("название_события");
//offLast отключает функцию чтения, которая была добавлена последней
```

Для отправки сообщений используйте функцию `send`:

```dart

RSocket socket = new RSocket({
    ip: "127.0.0.1:8080" // IP вашего сервера
})

socket.send(Event({
    type: "название_события",
    data: {
        "ключ": "значение",
        "ключ2": "значение2"
    }
    //ключ обязательно String
    //значение может принимать любой тип
}))
```

Также есть стандартные методы вроде `socket.connect`, `socket.disconnect`.
