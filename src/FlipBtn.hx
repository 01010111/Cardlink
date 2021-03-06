import motion.Actuate;
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
	var can_flip:Bool = true;

	public function new()
	{
		super(Main.i.scene);
		Main.i.flip = this;
		lineStyle(1, 0xFFFFFF);
		beginFill(0x000000);
		drawRect(PADDING * 2, PADDING * 2, (CARD_W * GRID_W) - PADDING * 4, GRID_H * 2 - PADDING * 4);
		endFill();
		setPosition(GRID_W, GRID_H);

		text = new Text(DefaultFont.get(), this);
		text.color.set(1,1,1);
		text.textAlign = Align.Center;
		text.setPosition((CARD_W * GRID_W) * 0.5, GRID_H - 8);
		text.text = 'REVEAL';

		int = new Interactive((CARD_W * GRID_W), GRID_H * 2, this);
		int.onClick = click;
	}

	public function click(?e:Event)
	{
		if (!can_flip || alpha == 0) return;
		can_flip = false;
		alpha = 0.5;
		Actuate.timer(FLIP_TIME).onComplete(() -> {
			can_flip = true;
			alpha = 1;
		});
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