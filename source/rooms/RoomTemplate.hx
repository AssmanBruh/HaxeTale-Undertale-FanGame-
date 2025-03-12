package rooms;

import backend.CoolState;
import flixel.FlxSprite;
import openfl.display.FPS;

/** NOT USE THIS, ONLY COPYPASTE AND EDIT**/
class RoomTitle extends RoomState {
    public function new(initialPositions:Array<Float>){
        super(initialPositions);
    }

    override function create() {
        FPS.inRoom = "RoomNamee";
        FPS.inState = Std.string(RoomTitle); //here the room file name :v
        // HERE BACKGROUND IMAGES / SPRITES
        // WHY??, because the bg still before of player and other entities
        super.create();
        // add entities here
        CustomTrace.log("PLAYER INITED POS: ["+player.x+","+player.y+"]");
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}