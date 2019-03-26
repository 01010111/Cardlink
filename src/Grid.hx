import h2d.Object;
import h2d.Interactive;
import h2d.Scene;
import h2d.Graphics;

using Math;

class Grid extends Graphics
{

	public function new(parent:Scene, gridw:Float, gridh:Float, color:Int, alpha:Float = 1)
	{
		super(parent);
		beginFill(color, alpha);
		for (j in 1...(parent.height / gridh).floor() + 1) for (i in 1...(parent.width / gridw).floor() + 1)
		{
			drawCircle(i * gridw, j * gridh, 1);
			var int = new Interactive(gridw, gridh, this);
			int.setPosition(i * gridw, j * gridh);
			int.onClick = (e) -> Main.i.add_card(i * gridw, j * gridh);
		}
		endFill();
	}

}