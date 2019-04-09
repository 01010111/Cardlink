import h2d.Interactive;
import hxd.res.DefaultFont;
import h2d.Text;

class HelpBtn extends Text
{

	public function new()
	{
		super(DefaultFont.get(), Main.i.scene);
		color.set(1);
		textAlign = Align.Right;
		setPosition(Main.i.scene.width - PADDING - 4, Main.i.scene.height - PADDING - 16);
		text = '?';
		var int = new Interactive(8, 16, this);
		int.onClick = (e) -> make_help_popup();
		int.setPosition(-7, 0);
	}

	function make_help_popup()
	{
		new HelpPopup();
	}

}