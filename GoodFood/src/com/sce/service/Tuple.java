package com.sce.service;

public class Tuple<X, Y> { 
    public final X x; 
    public final Y y; 
    public Tuple(X x, Y y) { 
        this.x = x; 
        this.y = y; 
    }

    @Override
    public String toString() {
        return "(" + x + "," + y + ")";
    }

    @SuppressWarnings("unchecked")
	@Override
    public boolean equals(Object other) {
        if (other == null) {
            return false;
        }
        if (other == this) {
            return true;
        }
        if (!(other instanceof Tuple)){
            return false;
        }

        return ((Tuple<X,Y>)other).x == this.x && ((Tuple<X,Y>)other).y == this.y;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((x == null) ? 0 : x.hashCode());
        result = prime * result + ((y == null) ? 0 : y.hashCode());
        return result;
    }
}