import h2d.Scene;
import js.Browser;
import h2d.Object;
import hxd.Key;

class Main extends hxd.App
{

    static function main() new Main();

	public static var i:Main;

	public var flip:FlipBtn;
	public var scene:Scene;

    override function init()
	{
		//hxd.Res.initEmbed();
		i = this;
		scene = s2d;
		scene.setFixedSize(Browser.window.innerWidth, Browser.window.innerHeight);
		CardUtil.init();
		new Grid(0xFFFFFF, 0.25);
		new DiscardPile();
		CardUtil.cards = new Object(scene);
		new FlipBtn();
		new Version();
		new ShareBtn();
		new DecksBtn();
		HttpUtil.check_url();
    }

	override public function update(dt)
	{
		super.update(dt);
		if (any_key_pressed([Key.SPACE, Key.ENTER])) flip.click();
		if (any_key_pressed([Key.DELETE, Key.BACKSPACE])) CardUtil.destroy_all();
	}

	function any_key_pressed(keys:Array<Int>)
	{
		for (key in keys) if (Key.isPressed(key)) return true;
		return false;
	}

	public function add_card(x:Float, y:Float):Card return new Card(x, y);

}
/*
+10-7-3-heavy
*/