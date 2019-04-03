using Math;

class URLHandler
{

	public static function check_url()
	{
		var url = js.Browser.window.location.href;
		trace('URL:', url);
		var split_url = url.split('?');
		if (split_url.length != 2) return;
		trace('Dynamic:', split_url[1]);
		var cards_data = split_url[1].split('+');
		for (data in cards_data) if (!validate_card(data)) return;
		for (data in cards_data) if (data.length > 0) add_card(data.split('-'));
	}

	static function validate_card(card:String):Bool
	{
		if (card.length == 0) return true;
		var data = card.split('-');
		if (data.length != 4) return false;
		for (i in 0...3) if (Math.isNaN(Std.parseInt(data[i]))) return false;
		if (Std.parseInt(data[3]) < 0 || Std.parseInt(data[3]) > 4) return false;
		return true;
	}

	static function add_card(data:Array<String>)
	{
		var x = Std.parseInt(data[0]) * GRID_W;
		var y = Std.parseInt(data[1]) * GRID_H;
		var suit = Std.parseInt(data[2]);
		var text = data[3];
		var card = new Card(x, y);
		card.set_data({ text: text, suit: ['hearts', 'diamonds', 'spades', 'clubs', 'special'][suit] });
		card.locked = true;
	}

	public static function get_url():String
	{
		var url = 'http://01010111.com/Cardlink/?';
		for (card in CardUtil.cards)
		{
			var card:Card = cast card;
			var data = card.get_data();
			url += '+${(card.x / GRID_W).round()}-${(card.y / GRID_H).round()}-${['hearts', 'diamonds', 'spades', 'clubs', 'special'].indexOf(data.suit)}-${data.text}';
		}
		return url;
	}

}