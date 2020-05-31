
import java.util.Iterator;

/**
 *
 * @author ashiber
 */
public class CubePairs implements Iterator<LongPair> {

    private Cube firstCube;
    private Cube secondCube;

    public CubePairs() {
        firstCube = new Cube((long) 0);
        secondCube = new Cube((long) 0);
    }

    @Override
    public boolean hasNext() {
        return firstCube.hasNext() && secondCube.hasNext();
    }

    @Override
    public void remove() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public LongPair next() {
        LongPair temp= new LongPair(this.firstCube.getCube(), this.secondCube.getCube()); 
        if (this.secondCube.getCube() < this.firstCube.getCube()) {
            this.secondCube.next();
        } else {
            this.firstCube.next();
            this.secondCube = new Cube((long) 0);
        }
        return temp;
    }
}
