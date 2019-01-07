package com.digou.util;

public class getExtension {
    public  static String extension(String fileName){
        int index = fileName.lastIndexOf(".");
        //获取文件扩展名
        if (index == -1) {
            return null;
        }
        return fileName.substring(index + 1);
    }
}
