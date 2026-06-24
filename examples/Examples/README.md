# Examples

## Box With Holes

### preview

<img src="../../examples-out/box-with-holes.png" alt="Box With Holes">

### 3D print

<img src="../../assets/box-with-holes.jpg" alt="Box With Holes" width="700">

## Buck Converter Case

### preview

<img src="../../examples-out/buck-converter-case.png" alt="Buck Converter Case">

### 3D print

<!-- <img src="../../assets/buck-converter-case.jpg" alt="Buck Converter Case"> -->

## Builtin Shapes 2D

### preview

<img src="../../examples-out/builtin-shapes-2d.png" alt="Builtin Shapes 2D">

## Viewports

PNG previews use per-example camera settings from [`viewports.json`](../viewports.json).
Keys match the output basename (e.g. `box-with-holes` for `box-with-holes.scad`).

```json
{
  "box-with-holes": {
    "translate": [0, 0, 0],
    "rotate": [55, 0, 25],
    "distance": 500
  }
}
```

A plain comma-separated gimbal string is also supported.
