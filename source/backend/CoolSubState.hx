package backend;

import entities.Player;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import openfl.geom.Rectangle;

class CoolSubState extends flixel.FlxSubState{
    var input:InputConstants;
	var border:Border;
	var borderCAM:FlxCamera;
    var gameWidth:Int = 640;
    var gameHeight:Int = 480;

    public function new() {
        super();
        input = new InputConstants();

        borderCAM = new FlxCamera();
        borderCAM.bgColor.alpha = 0;
        borderCAM.ID = 2;
        FlxG.cameras.add(borderCAM, false);

		border = new Border(Constants.borderPreffix, gameWidth, gameHeight);
		border.cameras = [borderCAM];
        add(border);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        input.initInput();
        if (input.FULLSCREEN){
            FlxG.fullscreen = !FlxG.fullscreen;
        }

        if (FlxG.keys.justPressed.F5){
            FlxG.resetGame();
        }
    }

    override function add(basic:FlxBasic):FlxBasic {
        var sprite = cast (basic, FlxSprite);
        if (sprite != null){
            // if (basic == cast (FlxBasic, Player)){
            // var player = cast (basic, FlxSprite);
            // if (player != null){
            //     if (sprite != player){
            //     sprite.x += 160;
            //     sprite.y += 32;
            // }}}
            // sep
            if (sprite != border){
				sprite.x += Constants.gameXAdds;
				sprite.y += Constants.gameYAdds;
            }
        }
        return super.add(basic);
    }

    override function close() {
        super.close();

        border.active = false;
        border.visible = false;
    }
}