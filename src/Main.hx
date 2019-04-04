import js.Browser;
import h2d.Object;
import hxd.Key;

class Main extends hxd.App
{

    static function main() new Main();

	public static var i:Main;

	var grid:Grid;
	var pile:DiscardPile;
	var flip:FlipBtn;

    override function init()
	{
		i = this;
		s2d.setFixedSize(Browser.window.innerWidth, Browser.window.innerHeight);
		//hxd.Res.initEmbed();
		CardUtil.populate_deck();
		grid = new Grid(s2d, 0xFFFFFF, 0.25);
		pile = new DiscardPile(s2d);
		flip = new FlipBtn(s2d);
		CardUtil.cards = new Object(s2d);
		new Version(s2d);
		URLHandler.check_url();
    }

	override public function update(dt)
	{
		super.update(dt);
		if (any_key_pressed([Key.SPACE, Key.ENTER])) flip.click();
		if (any_key_pressed([Key.DELETE, Key.BACKSPACE])) CardUtil.destroy_all();
		if (any_key_pressed([Key.U])) trace(URLHandler.get_url());
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