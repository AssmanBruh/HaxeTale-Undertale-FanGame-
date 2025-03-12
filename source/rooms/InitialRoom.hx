package rooms;

import backend.CoolState;
import flixel.FlxG;
import flixel.FlxSprite;
import openfl.display.FPS;

class InitialRoom extends RoomState {
    var fallRoom:FlxSprite;
    
    public function new(initialPositions:Array<Float>){
        super(initialPositions);
        // for back 
        // [1379, 276]

        // init
        // 315, 761
        // back
        // 298, 284
    }

    override function create() {
        FPS.inRoom = "InitialRoom";
        FPS.inState = Std.string(InitialRoom);
        fallRoom = new FlxSprite(0, -40).loadGraphic(AssetPaths.initRoom__png);
        fallRoom.antialiasing = false;
        // not be necss to reScale the sprite
        fallRoom.updateHitbox();
        add(fallRoom);
        super.create();
        CustomTrace.log("PLAYER INITED POS: ["+player.x+","+player.y+"]");
    }
    override function update(elapsed:Float) {
        super.update(elapsed);

        if (player.y < 276 && player.x > 1379){
            goToNextRoom();
        }

        if (input.MENU){
            startBattle();
        }
    }

    // we not can change the room route :v
    // amenos de que tu lo edites en el switch
    public function goToNextRoom() {
        trace("switching");
        FlxG.switchState(new Room0([479, 510]));
    }
}