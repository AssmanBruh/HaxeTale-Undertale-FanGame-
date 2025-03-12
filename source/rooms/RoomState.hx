package rooms;

import backend.CoolState;
import battle.Battle;
import battle.Soul;
import entities.Player;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;

/**
    Room Base
**/
class RoomState extends CoolState{
    var player:Player;
    // 5, 15*2.03
    public var initPositions:Array<Float> = [0,0];
    public function new(initialPos:Array<Float>) {
        super();
        if (initialPos == null){
            initialPos = [0,0];
        }
        this.initPositions = initialPos;
    }

    var BATTLE_CAM:FlxCamera;
    var blackBattleTransition:FlxSprite;
    var fakeSoul:Soul;
    override function create() {
        super.create();

        blackBattleTransition = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        blackBattleTransition.screenCenter();
        blackBattleTransition.scrollFactor.set();
        blackBattleTransition.visible = false;
        add(blackBattleTransition);
        blackBattleTransition.active = false;

        player = new Player(initPositions[0], initPositions[1]);
        add(player);
        player.x -= gameXAdds+18;
        player.y -= gameYAdds+27;

        fakeSoul = new Soul(player.x,player.x,player,true);
        fakeSoul.active = false;
        fakeSoul.visible = false;
        add(fakeSoul);

        FlxG.camera.follow(player, PLATFORMER);

        // Ajustar la deadzone
        FlxG.camera.deadzone.set(
            FlxG.width * 0.3, // Margen izquierdo
            FlxG.height * 0.4, // Margen superior
            FlxG.width * 0.4, // Ancho de la zona
            FlxG.height * 0.3  // Alto de la zona
        );

        BATTLE_CAM = new FlxCamera();
        BATTLE_CAM.bgColor.alpha = 0;
        BATTLE_CAM.ID = 3;
        FlxG.cameras.add(BATTLE_CAM, false);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }

    public function startBattle() {
        FlxG.sound.play(AssetPaths.sound("notice"), 0.688, false, null, true, function() {
        blackBattleTransition.active = true;
        blackBattleTransition.visible = true;
        player.visible = false;
        fakeSoul.active = true;
        FlxFlicker.flicker(fakeSoul, 1, 0.08, true, false, function(flick:FlxFlicker){
            // fakeSoul.active = false;
            // nothing
        });
        // timers time!!. wait... timers...time???. time...timers...rs... WHAT
        fastTimer(0.10, function() {
           player.visible = true; 
           FlxG.sound.play(AssetPaths.sound("countdown"), 0.9);
        });
        fastTimer(0.30, function() {
           FlxG.sound.play(AssetPaths.sound("countdown"), 0.9);
        });
        fastTimer(0.50, function() {
           FlxG.sound.play(AssetPaths.sound("countdown"), 0.9);
        });
        fastTimer(0.71, function() {
            FlxG.sound.play(AssetPaths.sound("countdown finish"), 0.9, false, null, true, function(){
                blackBattleTransition.active = true;
                blackBattleTransition.visible = true;
                // player.visible = false;
                fakeSoul.active = false;
                fakeSoul.visible = false;
                openSubState(new Battle(fakeSoul, player));
            });
        });
        // 1.8
        });
    }
    function fastTimer(time, onFinish:Void->Void) {
        new FlxTimer().start(time, function(tmr){
            if (onFinish != null){
                onFinish();
            }
        });
    }
}