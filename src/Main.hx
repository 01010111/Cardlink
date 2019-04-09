import hxd.res.DefaultFont;
import h2d.Text;
import motion.Actuate;
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
	public var ui:Array<Object> = [];
	public var instructions:Text;

    override function init()
	{
		i = this;
		scene = s2d;
		scene.setFixedSize(Browser.window.innerWidth, Browser.window.innerHeight);
		CardUtil.init();
		new Grid(0xFFFFFF, 0.25);
		new DiscardPile();
		new HelpBtn();
		ui.push(new Version());
		ui.push(new FlipBtn());
		ui.push(new ShareBtn());
		ui.push(new DecksBtn());
		CardUtil.cards = new Object(scene);
		HttpUtil.check_url();
		hide_ui();
    }

	function hide_ui()
	{
		for (object in ui) object.alpha = 0;
		instructions = new Text(DefaultFont.get(), scene);
		instructions.setPosition(scene.width/2 - 150, scene.height/2 - 8);
		instructions.textAlign = Align.Center;
		instructions.maxWidth = 300;
		instructions.text = 'Click anywhere to draw a card. Press the [?] button in the bottom right hand corner for help';
		instructions.color.set(1, 1, 1);
	}

	function show_ui()
	{
		if (ui[0].alpha > 0) return;
		scene.removeChild(instructions);
		for (object in ui) Actuate.tween(object, 0.5, { alpha: 1 });
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

	public function add_card(x:Float, y:Float):Card
	{
		show_ui();
		return new Card(x, y);
	}

}
/*
+10-7-3-heavy
*/