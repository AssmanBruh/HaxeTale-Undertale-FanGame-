package backend;

import entities.Player;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import openfl.geom.Rectangle;

class CoolState extends flixel.FlxState{
    var input:InputConstants;
    var border:FlxSprite;
    var gameWidth:Int = 640;
    var gameHeight:Int = 480;
    var borderCAM:FlxCamera;
    var gameXAdds = 160;
    var gameYAdds = 32;
    override function create() {
        super.create();

        input = new InputConstants();

        borderCAM = new FlxCamera();
        borderCAM.bgColor.alpha = 0;
        borderCAM.ID = 1;
        FlxG.cameras.add(borderCAM, false);

        border = new FlxSprite(0,0,AssetPaths.img("borders/border4"));
        border.pixels.fillRect(new Rectangle(Math.floor((FlxG.width-gameWidth)/2)-border.x, Math.floor((FlxG.height-gameHeight)/2),gameWidth,gameHeight), FlxColor.TRANSPARENT);
        border.updateHitbox();
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
            sprite.x += gameXAdds;
            sprite.y += gameYAdds;
            }
        }
        return super.add(basic);
    }

    override function closeSubState() {
        super.closeSubState();

        border.visible = true;
        border.active = true;
    }
    
    override function openSubState(SubState:FlxSubState) {
        super.openSubState(SubState);

        border.visible = false;
        border.active = false;
    }
}