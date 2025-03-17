package backend;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import openfl.geom.Rectangle;

class Border extends FlxSprite{
    public var border:String = "";
    public function new(border:String="", gameWidth = 640, gameHeight = 480) {
        super(0,0,AssetPaths.img("borders/"+border));
        
        this.border = border;
        pixels.fillRect(new Rectangle(Math.floor((FlxG.width-gameWidth)/2)-x, Math.floor((FlxG.height-gameHeight)/2),gameWidth,gameHeight), FlxColor.TRANSPARENT);
        updateHitbox();
    }
}