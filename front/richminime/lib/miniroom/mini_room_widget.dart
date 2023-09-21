import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';

class MiniRoomWidget extends StatelessWidget {
  const MiniRoomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: MiniRoom());
  }
}

// void main() {
//   runApp(GameWidget(game: MiniRoom()));
// }

class MiniRoom extends FlameGame with PanDetector {
  @override
  Color backgroundColor() => const Color(0xFFF5F5DC);
  late Player player;
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    player = Player();
    add(player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.game);
  }
}

class Player extends SpriteComponent with HasGameRef<MiniRoom> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('minime/default.png');

    position = gameRef.size / 2;
    width = 100;
    height = 100;
    anchor = Anchor.center;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
