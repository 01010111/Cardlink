import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Graphics;

class DiscardPile extends Graphics
{

	public static var i:DiscardPile;

	public function new()
	{
		i = this;

		super(Main.i.scene);
		lineStyle(2, 0xFF0000);
		drawRect(PADDING * 2, PADDING * 2, (CARD_W * GRID_W) - PADDING * 4, (CARD_H * GRID_H) - PADDING * 4);
		setPosition(GRID_W, GRID_H * 3);

		var text = new Text(DefaultFont.get(), this);
		text.color.set(1);
		text.textAlign = Align.Center;
		text.setPosition((CARD_W * GRID_W) * 0.5, (CARD_H * GRID_H) * 0.5 - 8);
		text.text = 'REMOVE';
		alpha = 0;
	}
}