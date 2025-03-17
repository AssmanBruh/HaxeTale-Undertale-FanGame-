package battle;

import backend.Constants;
import entities.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Soul extends FlxSprite{
    public var player:Player = null;
    public var forIntro:Bool = false;
	public var SPEED:Int = 180;

	var input:InputConstants;
	var inBack:Bool = false;
    public function new(X=0.0,Y=0.0,player:Player, forIntro:Bool=false) {
        super(X,Y);
        if (player != null)
            this.player = player;

        this.forIntro = forIntro;

		input = new InputConstants();

        loadGraphic(AssetPaths.img("battle/soul/soulSpriteSheet"), true, 20, 16);
        animation.add("soul", [0], 7, true);
        animation.add("break", [2], 7, true);
        animation.add("small", [1], 7, true);
        animation.play("soul"); // defalt anim
        antialiasing = false;
        updateHitbox();

        if (forIntro){
			// x = player.x - ((5 * Constants.PIXEL_MULT) / 2);
			// y = player.y - ((15 * Constants.PIXEL_MULT) / 2);
			x = (player.x / 2.03) + 5;
			y = (player.y / 2.03) + 15; // u8huhuhu
		} // hola
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		input.initInput();
		if (!forIntro || !inBack)
		{
			velocity.set(0, 0);
			checkInput();
		}
		if (FlxG.keys.justPressed.F1)
		{
			CustomTrace.log("SOUL POSITIONS: [" + x + ", " + y + "]");
		}
		// var gamepad = FlxG.gamepads.firstActive;
		// if (gamepad != null){
		// velocity.x = gamepad.getAxis(FlxGamepadInputID.TILT_ROLL) * 200;
		// velocity.y = gamepad.getAxis(FlxGamepadInputID.TILT_PITCH) * 200;
		// }
	}

	public function checkInput()
	{
		if (input.LEFT_P)
		{
			velocity.x = -SPEED;
		}
		if (input.UP_P)
		{
			velocity.y = -SPEED;
		}
		if (input.RIGHT_P)
		{
			velocity.x = SPEED;
		}
		if (input.DOWN_P)
		{
			velocity.y = SPEED;
		}
	}
    public function comeBackTodaHUD() {
		inBack = true;
		FlxTween.tween(this, {x: 46 + Constants.gameXAdds, y: 446 + Constants.gameYAdds}, 0.5, {
			ease: FlxEase.circIn,
			onComplete: function(twn)
			{
				inBack = false;
			}
		});
    }
}

class SoulParticles extends FlxSpriteGroup {
    public var soul:Soul;
    public var test:Bool = false;
    public function new(soul:Soul, test = false) {
        super();
        if (soul != null)
        this.soul = soul;

        this.test = test;
        for (i in 0...3){
             var p = new FlxSprite(soul.x, soul.y).loadGraphic(AssetPaths.img("battle/soul/soulSpriteSheet"), true, 20, 16);
             p.animation.add("particle"+i, [i+3]);
             p.animation.play("particle"+i);
             p.antialiasing = false;
             updateHitbox();
             if (test) // only trst if the anims work :V
             p.x += (p.width + 9)*i;
             add(p);
        }
    }   

}