import motion.Actuate;
import h2d.Interactive;
import h2d.Graphics;

using haxe.Json;

class ShareBtn extends Graphics
{

    static var radius:Int = 20;

    public function new()
    {
        super(Main.i.scene);
        smooth = true;
        beginFill(0xFF0000);
        var nodes:Array<{x:Float, y:Float}> = [];
        for (i in 0...3) nodes.push(MathUtil.point_on_circle(0, 0, radius, i * 360/3 + 180));
        beginFill(0xFF0000);
        for (node in nodes) drawCircle(node.x, node.y, radius/2);
        endFill();
        lineStyle(radius/4, 0xFF0000);
        lineTo(nodes[1].x, nodes[1].y);
        lineTo(nodes[0].x, nodes[0].y);
        lineTo(nodes[2].x, nodes[2].y);
        setPosition(Main.i.scene.width - GRID_W - radius - radius/2, GRID_H + radius + radius/2);
        setScale(0.5);
        
        var int = new Interactive(radius * 2.6, radius * 2.6, this);
        int.setPosition(-radius * 1.3, -radius * 1.3);
        int.onClick = (e) -> click();
        int.onOver = (e) -> scale_to(0.6);
        int.onOut = (e) -> scale_to(0.5);
    }

    function click()
    {
        if (alpha == 0) return;
        for (card in CardUtil.active_cards) if (card.get_data() == null) return pop_up('Flip cards before sharing!', '{}');
        HttpUtil.get_shortlink((e) -> pop_up('URL copied to clipboard', e), (e) -> pop_up('ERROR', e));
        setScale(0.75);
        scale_to(0.6);
    }
    
    function scale_to(v:Float) Actuate.tween(this, 0.2, { scaleX: v, scaleY: v });

    function pop_up(msg:String, e:String)
    {
        new PopUp(msg);
        var data = e.parse();
        if (data.shortLink == null) return;
        HttpUtil.copy_to_clipboard(data.shortLink);
    }

}