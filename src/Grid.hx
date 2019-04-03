import h2d.Interactive;
import h2d.Scene;
import h2d.Graphics;

using Math;

class Grid extends Graphics
{

	public function new(parent:Scene, color:Int, alpha:Float = 1)
	{
		super(parent);
		beginFill(color, alpha);
		for (j in 1...(parent.height / GRID_H).floor() + 1) for (i in 1...(parent.width / GRID_W).floor() + 1)
		{
			drawCircle(i * GRID_W, j * GRID_H, 1);
			var int = new Interactive(GRID_W, GRID_H, this);
			int.setPosition(i * GRID_W, j * GRID_H);
			int.onPush = (e) -> if (CardUtil.cards.children.length < CardUtil.num_cards) Main.i.add_card(i * GRID_W, j * GRID_H);
		}
		endFill();
	}

}