import backend.CoolState;
import entities.Player;
import flixel.FlxG;
import flixel.text.FlxText;
import input.InputConstants;
import rooms.InitialRoom;

class PlayState extends CoolState
{
    var tf = new FlxText();

    override public function create()
    {
        super.create();
        add(tf);

		var player = new Player();
		add(player);
		CustomTrace.log("hola test");
    }

    override public function update(elapsed:Float)
    {
		super.update(elapsed);
        tf.text = Std.string(FlxG.game.ticks);

		if (input.CLOSE_GAME){
			FlxG.switchState(InitialRoom.new);
		}
    }
}