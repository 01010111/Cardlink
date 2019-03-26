class Main extends hxd.App
{

    static function main() new Main();

	public static var i:Main;

    override function init()
	{
		i = this;
		CardUtil.populate_deck();
		new Grid(s2d, 0xFFFFFF, 0.25);
		new DiscardPile(s2d);
		new FlipBtn(s2d);
    }

	public function add_card(x:Float, y:Float) new Card(s2d, x, y);

}