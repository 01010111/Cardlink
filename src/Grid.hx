import h2d.Interactive;
import h2d.Graphics;

using Math;

class Grid extends Graphics
{

	public function new(color:Int, alpha:Float = 1)
	{
		super(Main.i.scene);
		beginFill(color, alpha);
		for (j in 1...(Main.i.scene.height / GRID_H).floor() + 1) for (i in 1...(Main.i.scene.width / GRID_W).floor() + 1)
		{
			drawCircle(i * GRID_W, j * GRID_H, 1);
			var int = new Interactive(GRID_W, GRID_H, this);
			int.setPosition(i * GRID_W, j * GRID_H);
			int.onPush = (e) -> if (CardUtil.cards.children.length < CardUtil.num_cards) Main.i.add_card(i * GRID_W, j * GRID_H);
		}
		endFill();
	}

}