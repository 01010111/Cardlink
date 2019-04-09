import js.Browser;
using haxe.Json;
using Math;
using StringTools;

@:expose
class HttpUtil
{

	static var card_separator:String = '+';
	static var value_separator:String = '|';
	static var suits:Array<String> = ['hearts', 'diamonds', 'spades', 'clubs'];

	public static function check_url()
	{
		var url = js.Browser.window.location.href;
		var split_url = url.split('?');
		if (split_url.length != 2) return;
		var cards_data = split_url[1].urlDecode().split('+');
		for (data in cards_data) if (!validate_card(data)) return;
		for (data in cards_data) if (data.length > 0) add_card(data.split(value_separator));
	}

	static function validate_card(card:String):Bool
	{
		if (card.length == 0) return true;
		var data = card.split(value_separator);
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
		card.set_data({ text: text, suit: suits[suit] });
		card.lock();
	}

	public static function get_url():String
	{
		var url = 'http://01010111.com/Cardlink/?';
		var str = '';
		for (card in CardUtil.cards)
		{
			var card:Card = cast card;
			var data = card.get_data();
			str += '$card_separator${(card.x / GRID_W).round()}$value_separator${(card.y / GRID_H).round()}$value_separator${suits.indexOf(data.suit)}$value_separator${data.text}';
		}
		return url += str.urlEncode();
	}

	public static function get_shortlink(on_data:String -> Void, on_error:String -> Void)
	{
		var request = new haxe.Http('https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyClYWNI-sA5nXkayNwTx72uL44ZYTMg9X4');
		var data = {
			dynamicLinkInfo: {
				domainUriPrefix: "https://cardlink.page.link",
				link: get_url()
			},
			suffix:{
				option:"SHORT"
			}
		}.stringify();
		request.setPostData(data);
		request.onData = on_data;
		request.onError = on_error;
		request.request(true);
	}

	public static function copy_to_clipboard(str:String)
	{
		var el = Browser.document.createTextAreaElement();
		el.value = str;
		Browser.document.body.appendChild(el);
		el.select();
		Browser.document.execCommand('copy');
		Browser.document.body.removeChild(el);
	}

}