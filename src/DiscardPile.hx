import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Graphics;

using Math;

class DiscardPile extends Graphics
{

	public static var i:DiscardPile;

	public function new()
	{
		i = this;

		super(Main.i.scene);

		draw_pile();
		setPosition(GRID_W, GRID_H * 3);

		var text = new Text(DefaultFont.get(), this);
		text.color.set(1);
		text.textAlign = Align.Center;
		text.setPosition((CARD_W * GRID_W) * 0.5, (CARD_H * GRID_H) * 0.5 - 8);
		text.text = 'REMOVE';
		
		alpha = 0;
	}

	/*function draw_pile()
	{
		lineStyle(2, 0xFF0000);
		drawRect(PADDING * 2, PADDING * 2, (CARD_W * GRID_W) - PADDING * 4, (CARD_H * GRID_H) - PADDING * 4);
	}*/

	function draw_pile()
	{
		var p1:Array<{x:Float, y:Float}> = [];
		var p2:Array<{x:Float, y:Float}> = [];

		var width = CARD_W * GRID_W - PADDING * 4;
		var height = CARD_H * GRID_H - PADDING * 4;

		var d = 8;
		var ii = (width/d).floor();
		var jj = (height/d).floor();

		for (i in 0...jj) p1.push({ x: 0, y: d * i });
		for (i in 0...ii) p1.push({ x: d * i, y: height });
		for (i in 0...ii) p2.push({ x: d * i, y: 0 });
		for (i in 0...jj) p2.push({ x: width, y: d * i });

		trace(p1);

		trace('$width/$height');

		for (i in 0...p1.length)
		{
			lineStyle(1, 0xFF0000);
			lineTo(p1[i].x + PADDING * 2, p1[i].y + PADDING * 2);
			lineTo(p2[i].x + PADDING * 2, p2[i].y + PADDING * 2);
			lineStyle();
		}

		beginFill();
		drawRect(width/2 - 32 + PADDING * 2, height/2 - 10 + PADDING * 2, 64, 20);
		endFill();
	}

}