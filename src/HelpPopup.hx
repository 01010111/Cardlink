import motion.Actuate;
import CardUtil.Deck;
import h2d.Interactive;
import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Graphics;

class HelpPopup extends Graphics
{

	public function new()
	{
		super(Main.i.scene);
		var int = new Interactive(Main.i.scene.width, Main.i.scene.height, this);
		beginFill(0x000000);
		drawRect(0, 0, Main.i.scene.width, Main.i.scene.height);
		endFill();

		var text = new Text(DefaultFont.get(), this);
		text.color.set(1, 1, 1);
		text.textAlign = Align.Left;
		text.maxWidth = 300;
		text.setPosition(Main.i.scene.width/2 - 150, Main.i.scene.height/2 - 300);
		text.text = "Welcome to Cardlink.\n\nCardlink is an intuitive way to generate ideas for game mechanics by physically placing cards, mentally assigning relationships to the cards based on how you've arranged them, and then revealing the cards' values.\n\nTo place a card, click anywhere on the grid.\n\nTo remove a card, drag it to the discard pile marked 'REMOVE'.\n\nTo remove all cards, use the keyboard shortcuts [DELETE] or [BACKSPACE].\n\nTo reveal or hide cards, use the button marked 'REVEAL/HIDE' or use the keyboard shortcuts [SPACE] or [ENTER].\n\nTo share the state of Cardlink, or save the state for later, hit the share button in the upper right hand corner.\n\nTo switch decks, use the deck button located under the share button.";

		new ReturnBtn(this);

		alpha = 0;
		Actuate.tween(this, 0.5, { alpha: 1 });
	}

	public function exit()
	{
		parent.removeChild(this);
	}

}

class ReturnBtn extends Graphics
{

	var height:Float = 48;
	var padding:Float = 8;

	public function new(parent:HelpPopup)
	{
		super(parent);

		var background = new Graphics(this);
		background.lineStyle(2, 0xFFFFFF);
		background.drawRect(0, 0, 300, height);

		var text = new Text(DefaultFont.get(), this);
		text.setPosition(150, PADDING + 12);
		text.textAlign = Align.Center;
		text.text = 'RETURN';

		setPosition(Main.i.scene.width/2 - 150, Main.i.scene.height/2 + 144);

		var int = new Interactive(Main.i.scene.width - padding * 4, height, this);
		int.onClick = (e) -> parent.exit();

		scaleX = 0;
		Actuate.tween(this, 0.1, { scaleX: 1 }).delay(0.5);
	}

}