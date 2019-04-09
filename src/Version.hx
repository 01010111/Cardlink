import hxd.res.DefaultFont;
import h2d.Text;

class Version extends Text
{

	public function new()
	{
		super(DefaultFont.get(), Main.i.scene);
		color.set(1);
		textAlign = Align.Right;
		setPosition(Main.i.scene.width - PADDING - 16, Main.i.scene.height - PADDING - 16);
		text = VERSION;
	}

}