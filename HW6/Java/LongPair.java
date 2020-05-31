

/**
 *
 * @author ashiber
 */
class LongPair {
   private long a;
    private long b;
    
    public LongPair(long a,long b){
    this.a=a;
    this.b=b;
    }

    /**
     * @return the a
     */
    public long getA() {
        return a;
    }

    /**
     * @param a the a to set
     */
    public void setA(long a) {
        this.a = a;
    }

    /**
     * @return the b
     */
    public long getB() {
        return b;
    }

    /**
     * @param b the b to set
     */
    public void setB(long b) {
        this.b = b;
    }
    public long getSum(){
        return a+b;
    }
}
