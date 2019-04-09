import h2d.Object;
import motion.Actuate;
import haxe.Json;
import Card.CardData;

using Math;

@:expose
class CardUtil
{

	public static var state:ECardsState = HIDDEN;
	public static var active_cards:Array<Card> = [];
	public static var cards:Object;
	public static var cards_data:Array<CardData> = [];
	public static var num_cards:Int = 0;
	public static var decks:Array<Deck>;
	public static var deck:Deck;

	public static function init()
	{
		get_decks();
		populate_deck(decks[0]);
	}

	public static function get_decks()
	{
		decks = cast Json.parse(haxe.Http.requestUrl('decks.json'));
	}

	public static function populate_deck(d:Deck)
	{
		deck = d;
		for (card in deck.diamonds) add_data({ text:card.text, suit:'diamonds' });
		for (card in deck.hearts) add_data({ text:card.text, suit:'hearts' });
		for (card in deck.spades) add_data({ text:card.text, suit:'spades' });
		for (card in deck.clubs) add_data({ text:card.text, suit:'clubs' });
	}

	static function add_data(data:CardData)
	{
		num_cards++;
		cards_data.push(data);
	}

	public static function add(card:Card) active_cards.push(card);
	public static function remove(card:Card) active_cards.remove(card);

	static function shuffle<T>(arr:Array<T>)
	{
		for (i in 0...arr.length)
		{
			var j = (arr.length * Math.random()).floor();
			var a = arr[i];
			var b = arr[j];
			arr[i] = b;
			arr[j] = a;
		}
		for (obj in arr) if (obj == null) arr.remove(obj);
	}

	public static function get_data(card:Card) 
	{
		var l = cards_data.length;
		shuffle(cards_data);
		card.set_data(cards_data.pop());
		if (l > cards_data.length) return;
		cards_data.pop();
	}

	public static function return_data(card:Card)
	{
		if (card.get_data() != null) cards_data.push(card.get_data());
	}

	public static function reveal()
	{
		for (card in active_cards) card.reveal();
		state = REVEALED;
	}

	public static function hide()
	{
		for (card in active_cards) card.hide();
		state = HIDDEN;
	}

	public static function destroy_all()
	{
		var i = 0;
		for (card in cards) Actuate.timer((cards.numChildren -  i++) * 0.1).onComplete(() -> {
			var card:Card = cast card;
			if (!card.locked) {
				card.bring_to_front();
				Actuate.tween(card, 0.2, { x: GRID_W, y: GRID_H }).onComplete(() -> card.destroy());
			}
		});
	}

	public static function swap_deck(deck:Deck)
	{
		while(cards_data.length > 0) cards_data.pop();
		for (card in active_cards) card.instant_destroy();
		populate_deck(deck);
	}

}

enum ECardsState
{
	REVEALED;
	HIDDEN;
}

typedef Deck =
{
	name:String,
	description:String,
	hearts:Array<{text:String}>,
	diamonds:Array<{text:String}>,
	clubs:Array<{text:String}>,
	spades:Array<{text:String}>,
}