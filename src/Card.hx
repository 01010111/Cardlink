import hxd.Event;
import h2d.Interactive;
import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Object;
import h2d.Graphics;

using Math;

class Card extends Graphics
{

	var held:Bool = false;
	var flipped:Bool;
	var offset:{x:Float,y:Float};

	var front:Object;
	var back:Object;
	var text:Text;
	var suit_top:Text;
	var suit_bottom:Text;
	var int:Interactive;

	var card_data(default, set):CardData;
	function set_card_data(data:CardData):CardData
	{
		text.text = data.text;

		switch (data.suit) {
			case 'hearts':
				suit_top.color.set(1, 0, 0.2);
				suit_bottom.color.set(1, 0, 0.2);
				suit_top.text = suit_bottom.text = 'H';
			case 'diamonds':
				suit_top.color.set(1, 0, 0.2);
				suit_bottom.color.set(1, 0, 0.2);
				suit_top.text = suit_bottom.text = 'D';
			case 'spades':
				suit_top.color.set();
				suit_bottom.color.set();
				suit_top.text = suit_bottom.text = 'S';
			case 'clubs':
				suit_top.color.set();
				suit_bottom.color.set();
				suit_top.text = suit_bottom.text = 'C';
			default:
				suit_top.color.set(1, 0, 0.2);
				suit_bottom.color.set(1, 0, 0.2);
				suit_top.text = suit_bottom.text = '*';
		}

		return card_data = data;
	}

	public function set_data(data:CardData) card_data = data;
	public function get_data():CardData return card_data;

	public function new(parent:h2d.Object, x:Float, y:Float)
	{
		super(parent);
		beginFill(0x000000);
		drawRoundedRect(PADDING - 1, PADDING - 1, (CARD_W * GRID_W) - PADDING * 2 + 2, (CARD_H * GRID_H) - PADDING * 2 + 2, CARD_R);
		beginFill(0xFFFFFF);
		drawRoundedRect(PADDING, PADDING, (CARD_W * GRID_W) - PADDING * 2, (CARD_H * GRID_H) - PADDING * 2, CARD_R);
		endFill();
		setPosition(x, y);

		front = new Object(this);
		back = new Object(this);

		text = new Text(DefaultFont.get(), front);
		text.color.set();
		text.textAlign = Align.Center;
		text.setPosition((CARD_W * GRID_W) * 0.5, (CARD_H * GRID_H) * 0.5 - 8);

		suit_top = new Text(DefaultFont.get(), front);
		suit_top.textAlign = Align.Center;
		suit_top.setPosition(PADDING + 16, PADDING + 16 - 8);

		suit_bottom = new Text(DefaultFont.get(), front);
		suit_bottom.textAlign = Align.Center;
		suit_bottom.setPosition((CARD_W * GRID_W) - PADDING - 16, (CARD_H * GRID_W) - PADDING - 16 - 8);

		var b = new Graphics(back);
		b.beginFill(0x000000);
		b.drawRoundedRect(PADDING * 2, PADDING * 2, (CARD_W * GRID_W) - PADDING * 4, (CARD_H * GRID_H) - PADDING * 4, CARD_R);
		b.endFill();

		/*var logo = new Bitmap(hxd.Res.logo.toTile().center(), back);
		logo.setPosition(CARD_W * GRID_W * 0.5, CARD_H * GRID_H * 0.5);
		logo.setScale(0.25);
		logo.smooth = true;*/

		int = new Interactive((CARD_W * GRID_W), (CARD_H * GRID_H), this);
		int.onPush = click;
		int.onRelease = release;

		switch (CardUtil.state) {
			case REVEALED: reveal();
			case HIDDEN: hide();
		}
		CardUtil.add(this);
	}

	function click(e:Event)
	{
		var p = parent;
		p.remove();
		p.addChild(this);
		int.startDrag(drag);
		offset = {x:e.relX, y:e.relY};
		//flipped ? hide() : reveal();
	}

	function drag(e:Event)
	{
		x += e.relX - offset.x;
		y += e.relY - offset.y;
	}

	function release(e:Event)
	{
		int.stopDrag();
		x = GRID_W * (x / GRID_W).round();
		y = GRID_H * (y / GRID_H).round();
		if (x == GRID_W && y == GRID_H) destroy();
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

	function destroy()
	{
		CardUtil.remove(this);
		CardUtil.return_data(this);
		parent.removeChild(this);
	}

}

typedef CardData =
{
	text:String,
	suit:String
}