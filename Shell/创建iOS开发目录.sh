#! /bin/bash

echo "创建文件夹"
mkdir -vp Class/{Expand/{Categorys/,Const/,DataBase/,Macros/,Network/,Tools/,},Framewroks/,Library/,Main/{Base/,Controller/,Model/,Views/,},Module/,Resource/{AppDelegete/,Golobal/,},}
echo "移动文件"

mv AppDelegate.h Class/Resource/AppDelegete/AppDelegate.h
mv AppDelegate.m Class/Resource/AppDelegete/AppDelegate.m
mv Assets.xcassets Class/Resource/Assets.xcassets
mv Base.lproj Class/Resource/Base.lproj
mv Info.plist Class/Resource/Info.plist
mv main.m Class/Resource/main.m


mv ViewController.h Class/Main/Controller/ViewController.h
mv ViewController.m Class/Main/Controller/ViewController.m