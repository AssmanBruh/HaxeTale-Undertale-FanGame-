package battle;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class Box extends FlxSpriteGroup {
    public var mark:FlxSprite;
    public var blackBox:FlxSprite;
    // x
    public var xBoundLeft:Float = 0;
    public var xBoundRight:Float = 640;
    // y
    public var yBoundUp:Float = 0;
    public var yBoundDown:Float = 480;
    ///////////////////////////////////
    public function new(xX, Y) {
        super();

        var  ass= new FlxSprite(xX, Y).loadGraphic(AssetPaths.img("battle/box/white"));
        mark = new FlxSprite(xX, Y).makeGraphic(Std.int(ass.width), Std.int(ass.height), FlxColor.WHITE);
		// mark.frames = grid;
		// mark.animation.addByPrefix("white", "white",0,false);
		// mark.animation.play("white");
		mark.updateHitbox();
        add(mark);
        //   6 is the border size   //
		var pene = new FlxSprite(mark.x+6.4, mark.y+5.9).loadGraphic(AssetPaths.img("battle/box/black"));
        
        blackBox= new FlxSprite(mark.x+6.4, mark.y+5.9).makeGraphic(Std.int(pene.width), Std.int(pene.height), FlxColor.BLACK);
		// blackBox.frames = grid;
		// blackBox.animation.addByPrefix("black", "black",0,false);
		// blackBox.animation.play("black");
		blackBox.updateHitbox();
        add(blackBox);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        var xLerp = FlxMath.lerp(blackBox.x, mark.x+6.4, elapsed*9);
        var yLerp = FlxMath.lerp(blackBox.y, mark.y+5.9, elapsed*9);
        var scaleXLerp = FlxMath.lerp(blackBox.scale.x, mark.scale.x-6, elapsed*9);
        var scaleYLerp = FlxMath.lerp(blackBox.scale.y, mark.scale.y-6, elapsed*9);
        blackBox.setPosition(xLerp, yLerp);
        blackBox.width = scaleXLerp;
        blackBox.height = scaleYLerp;
        // blackBox.scale.set(scaleXLerp, scaleYLerp);
        xBoundLeft = blackBox.x;
        xBoundRight = blackBox.width;
        yBoundUp = blackBox.y;
        yBoundDown = blackBox.height;
    }

    public function reScale(X,Y) {
        mark.scale.set(X,Y);
    }

    public function rePosition(X,Y) {
        mark.setPosition(X,Y);
    }
}