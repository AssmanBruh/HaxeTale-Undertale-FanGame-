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
    public function new(attachSoul:Soul, player:Player) {
        super();
        this.attachSoul = attachSoul;
        this.player = player;

        black = new FlxSprite(0,0);
        black.makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        black.screenCenter();
        black.scrollFactor.set();
        black.visible = false;
        add(black);
        black.active = false;

        bg = new Background("monster");
        add(bg);

        soul = new Soul(attachSoul.x, attachSoul.y,player,false);
        soul.comeBackTodaHUD();
        add(soul);

        for (i in 0...FlxG.cameras.list.length){
            CustomTrace.log("Camera: "+FlxG.cameras.list[i] + ", " + FlxG.cameras.list[i].ID);
        }
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

        new FlxTimer().start(5, function(tmr){
            close();
        });
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.SHIFT){
            add(new SoulParticles(attachSoul, true));
        }
    }

    override function close() {
        super.close();

        FlxG.cameras.list.remove(FlxG.cameras.list[FlxG.cameras.list.length - 1]);
        black.visible = false;
        black.active = false;
    }
}