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
	public static var deck:Array<CardData> = [];
	public static var num_cards:Int = 0;

	public static function populate_deck()
	{
		var deck_data = Json.parse(haxe.Http.requestUrl('cards.json'));
		var diamonds:Array<{text:String}> = deck_data.diamonds;
		var hearts:Array<{text:String}> = deck_data.hearts;
		var spades:Array<{text:String}> = deck_data.spades;
		var clubs:Array<{text:String}> = deck_data.clubs;
		var special:Array<{text:String}> = deck_data.special;
		for (card in diamonds) add_data({ text:card.text, suit:'diamonds' });
		for (card in hearts) add_data({ text:card.text, suit:'hearts' });
		for (card in spades) add_data({ text:card.text, suit:'spades' });
		for (card in clubs) add_data({ text:card.text, suit:'clubs' });
		for (card in special) add_data({ text:card.text, suit:'special' });
	}

	static function add_data(data:CardData)
	{
		num_cards++;
		deck.push(data);
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
		var l = deck.length;
		shuffle(deck);
		card.set_data(deck.pop());
		if (l > deck.length) return;
		deck.pop();
	}

	public static function return_data(card:Card)
	{
		if (card.get_data() != null) deck.push(card.get_data());
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
			card.bring_to_front();
			Actuate.tween(card, 0.2, { x: GRID_W, y: GRID_H }).onComplete(() -> card.destroy());
		});
	}

}

enum ECardsState
{
	REVEALED;
	HIDDEN;
}