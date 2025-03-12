package battle;

import flixel.FlxSprite;

class Background extends FlxSprite {
    var leBG:String = "";
    public function new(leBG:String) {
        super();
        this.leBG = leBG;

        switch (leBG){
            case "boss", "monster":
            loadGraphic(AssetPaths.img("battle/background/"+((leBG == "boss") ? "bossBG" : "monsterBG")));
            setPosition(22, 10);
            antialiasing = false;
            updateHitbox();
        }
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}