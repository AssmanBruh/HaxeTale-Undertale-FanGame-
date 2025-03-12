import backend.CoolState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import openfl.display.FPS;
import rooms.InitialRoom;

class TitleScreen extends CoolState {
    override function create() {
        super.create();
        FPS.inRoom = "TitleScreen";
        if (FPS.instance != null)
        FPS.instance.text += "\nCurrent State: " + Std.string(TitleScreen);
        var a = new FlxSprite(39, 47.45, AssetPaths.img("titlescene/test"));
        a.updateHitbox();
        add(a);

        new FlxTimer().start(6, function(tmr){
            FlxG.switchState(new InitialRoom([443, 216]));
        });
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}