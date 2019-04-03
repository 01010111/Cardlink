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
		//hxd.Res.initEmbed();
		CardUtil.populate_deck();
		grid = new Grid(s2d, 0xFFFFFF, 0.25);
		pile = new DiscardPile(s2d);
		flip = new FlipBtn(s2d);
    }

	override public function update(dt)
	{
		super.update(dt);
		if (Key.isPressed(Key.R)) flip.click();
		if (Key.isPressed(Key.D)) CardUtil.destroy_all();
	}

	public function add_card(x:Float, y:Float) new Card(s2d, x, y);

}