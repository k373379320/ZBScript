#!/bin/bash

# Generate UIImage extension for images assets

if [ $# -eq 0 ]; then
echo "Usage: ./ios_static_images.sh path_to_images_assets"
exit
fi

if [ ! -d $1 ]; then
echo "Usage: ./ios_static_images.sh path_to_images_assets"
exit
fi

echo "#import <UIKit/UIKit.h>" >UIImage+image.h
echo "">>UIImage+image.h
echo "@interface UIImage (image)" >>UIImage+image.h


echo "#import \"UIImage+image.h\"" >UIImage+image.m
echo "">>UIImage+image.m
echo "@implementation UIImage (image)">>UIImage+image.m
echo ""

ls -l $1 | \
grep imageset | \
awk '{ print $9; }' | \
awk -F"." '{ print $1; }' | \
awk -F"_" '{ \
out = $0" "; \
for (i = 1; i <= NF; i++) { \
if (i == 1) { \
out = out $i; \
} else { \
out = out toupper(substr($i,1,1)) substr($i,2); \
} \
}; \
print out \
}' | \
awk '{ \
print "+ (UIImage *)imageName_"$2"{"; \
print "    return [self imageNamed:@\"" $1 "\"];"; \
print "}\n"; \
}' >>UIImage+image.m



ls -l $1 | \
grep imageset | \
awk '{ print $9; }' | \
awk -F"." '{ print $1; }' | \
awk -F"_" '{ \
out = $0" "; \
for (i = 1; i <= NF; i++) { \
if (i == 1) { \
out = out $i; \
} else { \
out = out toupper(substr($i,1,1)) substr($i,2); \
} \
}; \
print out \
}' | \
awk '{ \
print ""
print "+ (UIImage *)imageName_"$2";"; \
}' >>UIImage+image.h


echo "@end" >>UIImage+image.h

echo "@end" >>UIImage+image.m

mv ${SRCROOT}/UIImage+image.h ${SRCROOT}/XZBDemo/Resource/UIImage+image.h
mv ${SRCROOT}/UIImage+image.m ${SRCROOT}/XZBDemo/Resource/UIImage+image.m