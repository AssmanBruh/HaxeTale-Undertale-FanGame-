package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.util.FlxColor;

class Player extends FlxSprite{
    var input:InputConstants;

    public var SPEED:Int = 180;
    public var RUN_SPEED:Int = 240;
    public function new(X=0.0,Y=0.0) {
        super(X,Y);
        // makeGraphic(45,45,FlxColor.LIME);
		loadGraphic(AssetPaths.img("player/greenhumansoul"), true, 19, 29);
        animation.add("down", [1, 2, 3, 0], 5, false);
        animation.add("idle-down", [0], 5, false);
        animation.add("walkLeft", [5, 4], 5, false);
        animation.add("idle-left", [4], 5, false);
        animation.add("walkRight", [7, 6], 5, false);
        animation.add("idle-right", [6], 5, false);
        animation.add("up", [9, 10, 11, 8], 5, false);
        animation.add("idle-up", [8], 5, false);
        animation.play("idle-down");
        // animation.curAnim.curFrame = 0;
        antialiasing = false;
        // drag.set(SPEED*3, SPEED*3);
        setGraphicSize(Std.int(width * Constants.PIXEL_MULT));
        updateHitbox();
        screenCenter();

        // init input
        input = new InputConstants();
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        input.initInput();

        velocity.set(0,0);
        checkInput();

        if (FlxG.keys.justPressed.F2){
            CustomTrace.log("PLAYER POSITIONS: ["+x + ", "+y+"]");
        }

        // var gamepad = FlxG.gamepads.firstActive;
        // if (gamepad != null){
        // velocity.x = gamepad.getAxis(FlxGamepadInputID.TILT_ROLL) * 200;
        // velocity.y = gamepad.getAxis(FlxGamepadInputID.TILT_PITCH) * 200;
        // }
    }

    public function checkInput(){
        if (input.LEFT_P){
            velocity.x = -SPEED;
            animation.play("walkLeft");
        }else if (input.LEFT_R){
            animation.play("idle-left");
            // if (animation.curAnim != null)
            // animation.curAnim.curFrame = 0;
        }

        if (input.UP_P){
            velocity.y = -SPEED;
            animation.play("up");
        }else if (input.UP_R){
            animation.play("idle-up");
            // if (animation.curAnim != null)
                // animation.curAnim.curFrame = 0;
        }

        if (input.RIGHT_P){
            velocity.x = SPEED;
            animation.play("walkRight");
        }else if (input.RIGHT_R){
            animation.play("idle-right");
            // if (animation.curAnim != null)
                // animation.curAnim.curFrame = 0;
        }

        if (input.DOWN_P){
            velocity.y = SPEED;
            animation.play("down");
        }else if (input.DOWN_R){
            animation.play("idle-down");
            // if (animation.curAnim != null)
                // animation.curAnim.curFrame = 0;
        }
    }
}