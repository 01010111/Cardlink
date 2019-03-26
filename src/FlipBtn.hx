import hxd.Event;
import h2d.Interactive;
import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Graphics;

class FlipBtn extends Graphics
{

	var text:Text;
	var int:Interactive;
	var flipped:Bool = false;

	public function new(parent:h2d.Object)
	{
		super(parent);
		lineStyle(1, 0xFFFFFF);
		beginFill(0x000000);
		drawRect(PADDING * 2, PADDING * 2, (CARD_W * GRID_W) - PADDING * 4, GRID_H * 2 - PADDING * 4);
		endFill();
		setPosition(GRID_W, GRID_H + (CARD_H * GRID_H));

		text = new Text(DefaultFont.get(), this);
		text.color.set(1,1,1);
		text.textAlign = Align.Center;
		text.setPosition((CARD_W * GRID_W) * 0.5, GRID_H - 8);
		text.text = 'REVEAL';

		int = new Interactive((CARD_W * GRID_W), GRID_H * 2, this);
		int.onClick = click;
	}

	function click(e:Event)
	{
		flipped ? {
			CardUtil.hide();
			text.text = 'REVEAL';
		} : {
			CardUtil.reveal();
			text.text = 'HIDE';
		};
		flipped = !flipped;
	}
}