package input;

import backend.CustomTrace;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

class InputConstants {
    // walk shitttts
    public var LEFT:Bool = false;
    public var RIGHT:Bool = false;
    public var UP:Bool = false;
    public var DOWN:Bool = false;
    public var LEFT_P:Bool = false;
    public var RIGHT_P:Bool = false;
    public var UP_P:Bool = false;
    public var DOWN_P:Bool = false;
    public var LEFT_R:Bool = false;
    public var RIGHT_R:Bool = false;
    public var UP_R:Bool = false;
    public var DOWN_R:Bool = false;
    // INTERACT // UI SHITS
    public var CONFIRM:Bool = false;
    public var CANCEL:Bool = false;
    public var MENU:Bool = false;
    public var CLOSE_GAME:Bool = false;

    // OTHER
    public var FULLSCREEN:Bool = false;
    public var DIALOGUE_SKIP:Bool = false;
    public var FLOWEY:Bool = false;
    
    // fuck off dialogue skip key :V
    var CANCEL_KEYS:Array<FlxKey> = [X, SHIFT];
    var CANCEL_BUTTONS:Array<FlxGamepadInputID> = [FlxGamepadInputID.B];

    public function new() {
        var gamepad = FlxG.gamepads.firstActive;
        CustomTrace.log("init input");
        // play with gamepad
        if (gamepad!=null){
            Main.isGamepad=true;
    		CustomTrace.log("Loaded Gamepad: "+gamepad);
        }else{
            // disconected
            Main.isGamepad=false;
        }
    }

    public function initInput() {
        var gamepad = FlxG.gamepads.firstActive;
        // play with gamepad
        if (gamepad!= null){
            // daaah, you will play with keyboard anyway
            // walk shitttts
            LEFT = justPressedGamePad([LEFT_STICK_DIGITAL_LEFT, DPAD_LEFT], gamepad) || justPressedKeys([A, FlxKey.LEFT]);
            RIGHT = justPressedGamePad([LEFT_STICK_DIGITAL_RIGHT, DPAD_RIGHT], gamepad) || justPressedKeys([D, FlxKey.RIGHT]);
            UP = justPressedGamePad([LEFT_STICK_DIGITAL_UP, DPAD_UP], gamepad) || justPressedKeys([W, FlxKey.UP]);
            DOWN = justPressedGamePad([LEFT_STICK_DIGITAL_DOWN, DPAD_DOWN], gamepad) || justPressedKeys([S, FlxKey.DOWN]);
            LEFT_P = pressedGamePad([LEFT_STICK_DIGITAL_LEFT, DPAD_LEFT], gamepad) || pressedKeys([A, FlxKey.LEFT]);
            RIGHT_P = pressedGamePad([LEFT_STICK_DIGITAL_RIGHT, DPAD_RIGHT], gamepad) || pressedKeys([D, FlxKey.RIGHT]);
            UP_P = pressedGamePad([LEFT_STICK_DIGITAL_UP, DPAD_UP], gamepad) || pressedKeys([W, FlxKey.UP]);
            DOWN_P = pressedGamePad([LEFT_STICK_DIGITAL_DOWN, DPAD_DOWN], gamepad) || pressedKeys([S, FlxKey.DOWN]);
            LEFT_R = releasedGamePad([LEFT_STICK_DIGITAL_LEFT, DPAD_LEFT], gamepad) || releasedKeys([A, FlxKey.LEFT]);
            RIGHT_R = releasedGamePad([LEFT_STICK_DIGITAL_RIGHT, DPAD_RIGHT], gamepad) || releasedKeys([D, FlxKey.RIGHT]);
            UP_R = releasedGamePad([LEFT_STICK_DIGITAL_UP, DPAD_UP], gamepad) || releasedKeys([W, FlxKey.UP]);
            DOWN_R = releasedGamePad([LEFT_STICK_DIGITAL_DOWN, DPAD_DOWN], gamepad) || releasedKeys([S, FlxKey.DOWN]);
            // INTERACT // UI SHITS
            CONFIRM = justPressedGamePad([FlxGamepadInputID.A], gamepad) || justPressedKeys([Z, ENTER]);
            CANCEL = justPressedGamePad(CANCEL_BUTTONS, gamepad) || justPressedKeys(CANCEL_KEYS);
            MENU = justPressedGamePad([FlxGamepadInputID.BACK, FlxGamepadInputID.START, FlxGamepadInputID.RIGHT_SHOULDER], gamepad) || justPressedKeys([C, CONTROL]);
            CLOSE_GAME = pressedGamePad([GUIDE], gamepad) || pressedKeys([ESCAPE]);
            // OTHER
            FULLSCREEN = justPressedGamePad([RIGHT_STICK_CLICK], gamepad) || justPressedKeys([F4]);
            DIALOGUE_SKIP = pressedGamePad(CANCEL_BUTTONS, gamepad) || pressedKeys(CANCEL_KEYS);
            FLOWEY = pressedGamePad([LEFT_STICK_CLICK], gamepad) || pressedKeys([F]);
        }else{ // or no??
            LEFT = justPressedKeys([A, FlxKey.LEFT]);
            RIGHT = justPressedKeys([D, FlxKey.RIGHT]);
            UP = justPressedKeys([W, FlxKey.UP]);
            DOWN = justPressedKeys([S, FlxKey.DOWN]);
            LEFT_P = pressedKeys([A, FlxKey.LEFT]);
            RIGHT_P = pressedKeys([D, FlxKey.RIGHT]);
            UP_P = pressedKeys([W, FlxKey.UP]);
            DOWN_P = pressedKeys([S, FlxKey.DOWN]);
            LEFT_R = releasedKeys([A, FlxKey.LEFT]);
            RIGHT_R = releasedKeys([D, FlxKey.RIGHT]);
            UP_R = releasedKeys([W, FlxKey.UP]);
            DOWN_R = releasedKeys([S, FlxKey.DOWN]);
            // INTERACT // UI SHITS
            CONFIRM = justPressedKeys([Z, ENTER]);
            CANCEL = justPressedKeys(CANCEL_KEYS);
            MENU = justPressedKeys([C, CONTROL]);
            CLOSE_GAME = pressedKeys([ESCAPE]);
            // OTHER
            FULLSCREEN = justPressedKeys([F4]);
            DIALOGUE_SKIP = pressedKeys(CANCEL_KEYS);
            FLOWEY = pressedKeys([F]);
        }

    }
    
    // KEYS
    public function justPressedKeys(keyses:Array<FlxKey>) {
        return FlxG.keys.anyJustPressed(keyses);
    }

    public function pressedKeys(keyses:Array<FlxKey>) {
        return FlxG.keys.anyPressed(keyses);
    }

    public function releasedKeys(keyses:Array<FlxKey>) {
        return FlxG.keys.anyJustReleased(keyses);
    }


    // GAMEPAD
    public function justPressedGamePad(buttons:Array<FlxGamepadInputID>, gamepad:FlxGamepad) {
        return gamepad.anyJustPressed(buttons);
    }

    public function pressedGamePad(buttons:Array<FlxGamepadInputID>, gamepad:FlxGamepad) {
        return gamepad.anyPressed(buttons);
    }

    public function releasedGamePad(buttons:Array<FlxGamepadInputID>, gamepad:FlxGamepad) {
        return gamepad.anyJustReleased(buttons);
    }

    // MO-MOBILE??   
}


// UUH!!!????
// LEFT = justPressedGamePad([LEFT_STICK_DIGITAL_LEFT, DPAD_LEFT], gamepad);
// RIGHT = justPressedGamePad([LEFT_STICK_DIGITAL_RIGHT, DPAD_RIGHT], gamepad);
// UP = justPressedGamePad([LEFT_STICK_DIGITAL_UP, DPAD_UP], gamepad);
// DOWN = justPressedGamePad([LEFT_STICK_DIGITAL_DOWN, DPAD_DOWN], gamepad);
// LEFT_P = pressedGamePad([LEFT_STICK_DIGITAL_LEFT, DPAD_LEFT], gamepad);
// RIGHT_P = pressedGamePad([LEFT_STICK_DIGITAL_RIGHT, DPAD_RIGHT], gamepad);
// UP_P = pressedGamePad([LEFT_STICK_DIGITAL_UP, DPAD_UP], gamepad);
// DOWN_P = pressedGamePad([LEFT_STICK_DIGITAL_DOWN, DPAD_DOWN], gamepad);
// LEFT_R = releasedGamePad([LEFT_STICK_DIGITAL_LEFT, DPAD_LEFT], gamepad);
// RIGHT_R = releasedGamePad([LEFT_STICK_DIGITAL_RIGHT, DPAD_RIGHT], gamepad);
// UP_R = releasedGamePad([LEFT_STICK_DIGITAL_UP, DPAD_UP], gamepad);
// DOWN_R = releasedGamePad([LEFT_STICK_DIGITAL_DOWN, DPAD_DOWN], gamepad);
// // INTERACT // UI SHITS
// CONFIRM = justPressedGamePad([FlxGamepadInputID.A], gamepad);
// CANCEL = justPressedGamePad(CANCEL_BUTTONS, gamepad);
// MENU = justPressedGamePad([FlxGamepadInputID.BACK, FlxGamepadInputID.START, FlxGamepadInputID.RIGHT_SHOULDER], gamepad);
// CLOSE_GAME = pressedGamePad([GUIDE], gamepad);
// // OTHER
// FULLSCREEN = justPressedGamePad([RIGHT_STICK_CLICK], gamepad);
// DIALOGUE_SKIP = pressedGamePad(CANCEL_BUTTONS, gamepad);
// FLOWEY = pressedGamePad([LEFT_STICK_CLICK], gamepad);