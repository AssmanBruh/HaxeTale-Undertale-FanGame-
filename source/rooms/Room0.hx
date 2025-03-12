package rooms;

import backend.CoolState;
import flixel.FlxSprite;
import openfl.display.FPS;

class Room0 extends RoomState {
    public function new(initialPos:Array<Float>){
        super(initialPos);
        this.initPositions = initialPos;
    }

    // sup. just a one
    var bg:FlxSprite;
    var floweyMap:FlxSprite;
    override function create() {
        FPS.inRoom = "Room0";
        FPS.inState = Std.string(Room0); 
        bg = new FlxSprite(-1, -373, AssetPaths.img("rooms/room0"));
        bg.antialiasing = false;
        bg.updateHitbox();
        add(bg);
        super.create();
        // add entities here
        floweyMap = new FlxSprite(322, 289).loadGraphic(AssetPaths.img("monsters/flowey/floweySpriteSheet"), true, 25, 32);
        floweyMap.animation.add("talk", [0, 1], 5, true);
        floweyMap.animation.add("idle", [0], 5, false);
        floweyMap.animation.add("face-grow", [2, 3, 4, 5, 6, 7, 8, 9], 5, false);
        floweyMap.animation.add("laugh", [10, 11, 12], 5, true);
        floweyMap.animation.add("stink", [13, 14, 15, 16, 17], 5, false);
        floweyMap.animation.add("empty", [18], 5, false);
        floweyMap.animation.play("idle");
        floweyMap.antialiasing = false;
        floweyMap.setGraphicSize(Std.int(floweyMap.width * Constants.PIXEL_MULT));
        floweyMap.updateHitbox();
        add(floweyMap);
        CustomTrace.log("PLAYER INITED POS: ["+player.x+","+player.y+"]");
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}