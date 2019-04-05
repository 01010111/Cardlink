import h2d.Scene;
import h2d.Graphics;

class ShareBtn extends Graphics
{

    static var radius:Int = 16;

    public function new(parent:Scene)
    {
        super(parent);
        beginFill(0xFF0000);
        var nodes:Array<Array<Float>> = [[radius, -radius], [-radius, 0], [radius, radius]];
        beginFill(0xFF0000);
        for (node in nodes) drawCircle(node[0], node[1], radius/2);
        endFill();
        setPosition(parent.width - GRID_W - radius, GRID_H + radius);
    }

}