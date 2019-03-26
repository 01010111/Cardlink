class Main extends hxd.App
{

	public static var i:Main;

    override function init()
	{
		i = this;
		CardUtil.populate_deck();
		new Grid(s2d, 16, 16, 0xFFFFFF, 0.25);
    }

	public function add_card(x:Float, y:Float)
	{
		new Card(s2d, x, y);
	}

    static function main()
	{
        new Main();
    }

}