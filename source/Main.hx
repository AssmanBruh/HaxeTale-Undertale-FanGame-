package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
import rooms.InitialRoom;

class Main extends Sprite
{
	public static var isGamepad:Bool = false;
	var gameFrame:Int = 60;
	var fps:FPS;
	public function new()
	{
		super();
		fps = new FPS(10,10);
		addChild(new FlxGame(0, 0, TitleScreen, gameFrame, gameFrame, true, false));
		FlxG.autoPause = false;

		addChild(fps);
	}
}
