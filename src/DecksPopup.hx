import motion.Actuate;
import CardUtil.Deck;
import h2d.Interactive;
import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Graphics;

class DecksPopup extends Graphics
{

	public var selected_deck:Deck;
	public var decks:Array<DeckInfo> = [];

	var last_deck:Deck;

	public function new()
	{
		super(Main.i.scene);
		beginFill(0x000000);
		drawRect(0, 0, Main.i.scene.width, Main.i.scene.height);
		var j = 0;
		for (deck in CardUtil.decks) decks.push(new DeckInfo(deck, j++, this));
		new LoadDeckBtn(j++, this);
		last_deck = CardUtil.deck;
		alpha = 0;
		Actuate.tween(this, 0.5, { alpha: 1 });
	}

	public function select(deck:DeckInfo)
	{
		for (deck in decks) deck.deselect();
		selected_deck = deck.deck;
		deck.select();
	}

	public function exit()
	{
		parent.removeChild(this);
		if (last_deck.name != selected_deck.name) CardUtil.swap_deck(selected_deck);
	}

}

class DeckInfo extends Graphics
{

	public var deck:Deck;
	
	var deck_name:Text;
	var description:Text;
	var background:Graphics;
	var index:Int;
	var height:Float = 48;
	var padding:Float = 8;

	public function new(deck:Deck, j:Int, parent:DecksPopup)
	{
		super(parent);

		index = j;
		this.deck = deck;

		background = new Graphics(this);
		background.lineStyle(2, 0xFFFFFF);
		background.drawRect(0, 0, Main.i.scene.width - padding * 4, height);

		deck_name = new Text(DefaultFont.get(), this);
		deck_name.setPosition(padding * 2, padding);
		deck_name.text = '* ${deck.name}';

		description = new Text(DefaultFont.get(), this);
		description.setPosition(padding * 2 + 16, padding + 16);
		description.text = deck.description;

		setPosition(padding * 2, padding * 2 + j * (height + padding * 2));

		CardUtil.deck.name == deck.name ? parent.select(this) : deselect();

		var int = new Interactive(Main.i.scene.width - padding * 4, height, this);
		int.onClick = (e) -> parent.select(this);

		scaleX = 0;
		Actuate.tween(this, 0.1, { scaleX: 1 }).delay(0.5 + j * 0.05);
	}

	public function select()
	{
		deck_name.color.set(1, 1, 1);
		description.color.set(1, 1, 1);
		background.color.set(1, 1, 1);
	}

	public function deselect()
	{
		deck_name.color.set(1);
		description.color.set(1);
		background.color.set(1);
	}

}

class LoadDeckBtn extends Graphics
{

	var height:Float = 48;
	var padding:Float = 8;

	public function new(j:Int, parent:DecksPopup)
	{
		super(parent);

		var background = new Graphics(this);
		background.lineStyle(2, 0xFFFFFF);
		background.drawRect(0, 0, Main.i.scene.width - padding * 4, height);

		var text = new Text(DefaultFont.get(), this);
		text.setPosition((Main.i.scene.width - padding * 4)/2, PADDING + 12);
		text.textAlign = Align.Center;
		text.text = 'LOAD DECK';

		setPosition(padding * 2, padding * 2 + j * (height + padding * 2));

		var int = new Interactive(Main.i.scene.width - padding * 4, height, this);
		int.onClick = (e) -> parent.exit();

		scaleX = 0;
		Actuate.tween(this, 0.1, { scaleX: 1 }).delay(0.5 + j * 0.05);
	}

}