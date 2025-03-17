package battle;

import backend.CoolSubState;
import battle.Soul.SoulParticles;
import entities.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Battle extends CoolSubState{
    var bg:Background;
    var black:FlxSprite;
    public var attachSoul:Soul;
    var soul:Soul;
    public var player:Player;
	var ui:UI;

	public var box:Box;
    public function new(attachSoul:Soul, player:Player) {
        super();
        this.attachSoul = attachSoul;
        this.player = player;

        black = new FlxSprite(0,0);
		black.makeGraphic(gameWidth, gameHeight, 0xFF000000);
		// black.screenCenter();
        black.scrollFactor.set();
		black.visible = true;
        add(black);
		black.active = true;

        bg = new Background("monster");
        add(bg);

		box = new Box(169.95, 249.85);
		box.screenCenter(X);
		add(box);

		ui = new UI("CACA", 1, 20);
		add(ui);

		soul = new Soul(attachSoul.x, attachSoul.y, player, true);
        soul.comeBackTodaHUD();
        add(soul);

        for (i in 0...FlxG.cameras.list.length){
            CustomTrace.log("Camera: "+FlxG.cameras.list[i] + ", " + FlxG.cameras.list[i].ID);
        }
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

		if (soul.x < box.xBoundLeft)
			soul.x = box.xBoundLeft;
		if (soul.y < box.yBoundUp)
			soul.y = box.yBoundUp;
		if (soul.x + soul.width > box.xBoundLeft + box.xBoundRight)
			soul.x = box.xBoundLeft + box.xBoundRight - soul.width;
		if (soul.y + soul.height > box.yBoundUp + box.yBoundDown)
			soul.y = box.yBoundUp + box.yBoundDown - soul.height;

		if (FlxG.keys.justPressed.SIX)
		{
			soul.forIntro = false;
		}

		if (FlxG.keys.justPressed.EIGHT)
		{
			close();
		}

        if (FlxG.keys.justPressed.SHIFT){
            add(new SoulParticles(attachSoul, true));
        }
		if (FlxG.keys.justPressed.ONE)
		{
			box.reScale(4, 1);
		}
		if (FlxG.keys.justPressed.TWO)
		{
			box.reScale(0.45, 0.45);
		}
    }

    override function close() {
        super.close();

		// FlxG.cameras.list.remove(FlxG.cameras.list[FlxG.cameras.list.length - 1]);
        black.visible = false;
        black.active = false;
    }
}