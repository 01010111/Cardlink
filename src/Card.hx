import h2d.Bitmap;
import motion.Actuate;
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
	var locked:Bool = false;
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
		if (card_data != null) CardUtil.return_data(this);

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

	public function new(x:Float, y:Float)
	{
		super(CardUtil.cards);
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

		scaleX = 0;
		front.alpha = 0;
		back.alpha = 0;

		switch (CardUtil.state) {
			case REVEALED: reveal();
			case HIDDEN: hide();
		}
		
		CardUtil.add(this);
		CardUtil.get_data(this);
	}

	var last:{x:Float, y:Float} = { x:0, y:0 };

	function click(e:Event)
	{
		bring_to_front();
		int.startDrag(drag);
		offset = {x:e.relX, y:e.relY};
		held = true;
		last.x = x;
		last.y = y;
		Actuate.timer(1).onComplete(() -> check_lock());
	}

	function check_lock()
	{
		if (!held) return;
		if (Math.abs(last.x - x) > GRID_W) return;
		if (Math.abs(last.y - y) > GRID_H) return;
		locked ? unlock() : lock();
	}

	public function lock()
	{
		locked = true;
		text.color.set(1);
	}

	public function unlock()
	{
		locked = false;
		text.color.set();
	}

	public function bring_to_front()
	{
		parent.children.push(parent.children.splice(parent.children.indexOf(this), 1)[0]);
	}

	function drag(e:Event)
	{
		x += e.relX - offset.x;
		y += e.relY - offset.y;
	}

	function release(e:Event)
	{
		int.stopDrag();
		held = false;
		Actuate.tween(this, 0.1, { x: GRID_W * (x / GRID_W).round(), y: GRID_H * (y / GRID_H).round() }).onComplete(() -> if (x == GRID_W && y == GRID_H) destroy());
	}

	public function reveal() flip(true);
	public function hide() flip(false);

	public function flip(show:Bool)
	{
		if (!locked) show ? CardUtil.get_data(this) : CardUtil.return_data(this);
		Actuate.tween(this, FLIP_TIME/2, { scaleX: 0, x: x + CARD_W * GRID_W * 0.5 }).onComplete(() -> {
			front.alpha = show ? 1 : 0;
			back.alpha = show ? 0 : 1;
			flipped = show;
			Actuate.tween(this, FLIP_TIME/2, { scaleX: 1, x: x - CARD_W * GRID_W * 0.5 });
		});
	}

	public function destroy()
	{
		Actuate.tween(this, 0.2, { scaleX: 0, scaleY: 0, x: x + CARD_W * GRID_W * 0.5, y: y + CARD_H * GRID_H * 0.5 }).onComplete(() -> {
			CardUtil.remove(this);
			CardUtil.return_data(this);
			parent.removeChild(this);
		});
	}

}

typedef CardData =
{
	text:String,
	suit:String
}