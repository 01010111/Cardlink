import h2d.Scene;
import hxd.res.DefaultFont;
import h2d.Text;

class Version extends Text
{

	public function new(parent:Scene)
	{
		super(DefaultFont.get(), parent);
		color.set(1);
		textAlign = Align.Right;
		setPosition(parent.width - PADDING, parent.height - PADDING - 16);
		text = VERSION;
	}

}