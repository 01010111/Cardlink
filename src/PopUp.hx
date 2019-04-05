import h2d.Interactive;
import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Graphics;

class PopUp extends Graphics
{

	public function new(s:String)
	{
		super(Main.i.scene);
		beginFill(0x000000, 0.5);
		drawRect(0, 0, Main.i.scene.width, Main.i.scene.height);
		endFill();
		
		var text = new Text(DefaultFont.get(), this);
		text.setPosition(Main.i.scene.width/2, Main.i.scene.height/2 - 16);
		text.color.set(1);
		text.textAlign = Align.Center;
		text.text = s += '\nClick anywhere to dismiss';

		var int = new Interactive(Main.i.scene.width, Main.i.scene.height, this);
		int.onClick = (e) -> parent.removeChild(this);
	}

}