import haxe.Json;
import Card.CardData;

using Math;

class CardUtil
{

	static var deck:Array<CardData> = [];

	public static function populate_deck()
	{
		var deck_data = Json.parse(haxe.Http.requestUrl('cards.json'));
		var diamonds:Array<{text:String}> = deck_data.diamonds;
		var hearts:Array<{text:String}> = deck_data.hearts;
		var spades:Array<{text:String}> = deck_data.spades;
		var clubs:Array<{text:String}> = deck_data.clubs;
		var special:Array<{text:String}> = deck_data.special;
		for (card in diamonds) deck.push({ text:card.text, suit:'diamonds' });
		for (card in hearts) deck.push({ text:card.text, suit:'hearts' });
		for (card in spades) deck.push({ text:card.text, suit:'spades' });
		for (card in clubs) deck.push({ text:card.text, suit:'clubs' });
		for (card in special) deck.push({ text:card.text, suit:'special' });
	}

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
	}

	public static function get_data(card:Card) 
	{
		shuffle(deck);
		var data = null;
		while (data == null) data = deck.shift();
		card.set_data(data);
	}

	public static function return_data(card:Card)
	{
		deck.push(card.get_data());
	}

}