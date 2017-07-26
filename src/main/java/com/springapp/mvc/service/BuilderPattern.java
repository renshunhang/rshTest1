package com.springapp.mvc.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * author：renshunhang
 * date：2017/6/14.
 */
public class BuilderPattern {
    private final int servingSize;
    private final int servings;
    private final int a;

    public BuilderPattern(Builder builder) {
        servings = builder.servings;
        servingSize = builder.servingSize;
        a=builder.a;
    }

    public static class Builder{
        private final int servingSize;
        private final int servings;

        private int a=0;

        public Builder(int servingSize,int servings){
            this.servings =  servings;
            this.servingSize = servingSize;
        }
        public Builder abs(int val){
            a = val;
            return this;
        }

        public BuilderPattern  build(){
            return new BuilderPattern(this);
        }

    }

    public static void main(String[] args){
        BuilderPattern builderPattern = new BuilderPattern.Builder(10,1).abs(1).build();
        ConcurrentHashMap hashMap = new ConcurrentHashMap();

        HashSet hashSet = new HashSet();

    }

}
