import h2d.Interactive;
import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Object;
import h2d.Graphics;

class Card extends Graphics
{

	var width:Float = 96;
	var height:Float = 144;
	var radius:Float = 2;
	var padding:Float = 2;
	var held:Bool = false;
	var flipped:Bool;
	var offset:{x:Float,y:Float};

	var front:Object;
	var back:Object;
	var text:Text;

	var card_data(default, set):CardData;
	function set_card_data(data:CardData):CardData
	{
		text.text = data.text;
		return card_data = data;
	}

	public function set_data(data:CardData) card_data = data;
	public function get_data():CardData return card_data;

	public function new(parent:h2d.Object, x:Float, y:Float)
	{
		super(parent);
		beginFill(0x000000);
		drawRoundedRect(padding - 1, padding - 1, width - padding * 2 + 2, height - padding * 2 + 2, radius);
		beginFill(0xFFFFFF);
		drawRoundedRect(padding, padding, width - padding * 2, height - padding * 2, radius);
		endFill();
		setPosition(x, y);

		front = new Object(this);
		back = new Object(this);

		text = new Text(DefaultFont.get(), front);
		text.color.set();
		text.textAlign = Align.Center;
		text.setPosition(width * 0.5, height * 0.5 - 8);

		var b = new Graphics(back);
		b.beginFill(0x000000);
		b.drawRoundedRect(padding * 2, padding * 2, width - padding * 4, height - padding * 4, radius);
		b.endFill();

		hide();

		var int = new Interactive(width, height, this);
		int.onClick = click;
		int.onRelease = release;
		int.onMove = drag;
	}

	function click(e)
	{
		var p = parent;
		p.remove();
		p.addChild(this);
		held = true;
		//flipped ? hide() : reveal();
	}

	function release(e)
	{
		held = false;
	}

	function drag(e)
	{
		if (!held) return;
		x = 
	}

	public function reveal()
	{
		CardUtil.get_data(this);
		back.alpha = 0;
		front.alpha = 1;
		flipped = true;
	}

	public function hide()
	{
		CardUtil.return_data(this);
		back.alpha = 1;
		front.alpha = 0;
		flipped = false;
	}

}

typedef CardData =
{
	text:String,
	suit:String
}