package battle;

import backend.Constants;
import entities.Player;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;

class Soul extends FlxSprite{
    public var player:Player = null;
    public var forIntro:Bool = false;
    public function new(X=0.0,Y=0.0,player:Player, forIntro:Bool=false) {
        super(X,Y);
        if (player != null)
            this.player = player;

        this.forIntro = forIntro;

        loadGraphic(AssetPaths.img("battle/soul/soulSpriteSheet"), true, 20, 16);
        animation.add("soul", [0], 7, true);
        animation.add("break", [2], 7, true);
        animation.add("small", [1], 7, true);
        animation.play("soul"); // defalt anim
        antialiasing = false;
        updateHitbox();

        if (forIntro){
            x = player.x + ((5*Constants.PIXEL_MULT) / 2);
            y = player.y + ((15*Constants.PIXEL_MULT) / 2);
        }
    }

    public function comeBackTodaHUD() {

        // FlxTween.tween(this, {x: , y:});
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