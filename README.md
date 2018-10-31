# Intrinsic Dirac Operator 
This Matlab library is based on the paper: 
```
@article{ye2018dirac,
author = {Ye, Zi and Diamanti, Olga and Tang, Chengcheng and Guibas, Leonidas and Hoffmann, Tim},
title = {A unified discrete framework for intrinsic and extrinsic Dirac operators for geometry processing},
journal = {Computer Graphics Forum},
volume = {37},
number = {5},
pages = {93-106},
}
```
## Dependencies
Some of our functions would require the [gptoolbox - a geometry processing toolbox](https://github.com/alecjacobson/gptoolbox) by [Alex Jacobson](http://www.cs.toronto.edu/~jacobson/). 

## Functions
* dirac_immersion.m     -   produce intrinsic Dirac immersions.
* willmore_fairing.m    -   reduce the Willmore energy via conformal Willmore flow [2].
* curvature_transfer.m  -   transfer the mean curvature half-density from a shape to another.
* curvature_transfer_iter.m  -   transfer the mean curvature half-density from a shape to another via a iteration process.
 
## References:
    [1] K. Crane, U. Pinkall, and P. Schröder, “Spin transformations of discrete surfaces,” ACM Transactions on Graphics, vol. 30, no. 4, p. 1, Jul. 2011.
    
    [2] K. Crane, U. Pinkall, and P. Schröder, “Robust fairing via conformal curvature flow,” ACM Transactions on Graphics, vol. 32, no. 4, p. 1, Jul. 2013.
    
    [3] H.-T. D. Liu, A. Jacobson, and K. Crane, “A Dirac Operator for Extrinsic Shape Analysis,” Computer Graphics Forum, vol. 36, no. 5, pp. 139–149, Aug. 2017.

### License
MIT
